//
//  ProfileViewController.m
//  Instagram
//
//  Created by Archita Singh on 6/29/22.
//

#import "ProfileViewController.h"
#import "Post.h"
#import "InstagramCell.h"
#import "PFImageView.h"
#import "DateTools.h"

@interface ProfileViewController () <UIImagePickerControllerDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *pfpTableView;
@property (nonatomic, strong) NSMutableArray *arrayOfPosts;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTimeline];
    
    self.pfpTableView.estimatedRowHeight = UITableViewAutomaticDimension;
    
    PFUser *user = PFUser.currentUser;
    self.username.text = [@"@" stringByAppendingString: user.username];
    
    self.profilePic.file = user[@"profilePicture"];
    [self.profilePic loadInBackground];
    
    self.profilePic.layer.cornerRadius = 50;
    self.profilePic.layer.masksToBounds = YES;
    
    self.pfpTableView.dataSource = self;
    [self.pfpTableView reloadData];
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(beginRefresh:) forControlEvents:UIControlEventValueChanged];
       [self.pfpTableView insertSubview:refreshControl atIndex:0];
    
}

- (void)beginRefresh:(UIRefreshControl *)refreshControl {
    [self createTimeline];
    
    self.pfpTableView.dataSource = self;

    [self.pfpTableView reloadData];
    [refreshControl endRefreshing];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // Get the image captured by the UIImagePickerController
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];

    // Do something with the images (based on your use case)
    self.profilePic.image = editedImage;
    
    PFUser *user = PFUser.currentUser;
    user[@"profilePicture"] = [self getPFFileFromImage:self.profilePic.image];
    [user saveInBackground];
    
    // Dismiss UIImagePickerController to go back to your original view controller
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)getCameraRoll:(id)sender {
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    
    [self presentViewController:imagePickerVC animated:YES completion:nil];

    // The Xcode simulator does not support taking pictures, so let's first check that the camera is indeed supported on the device before trying to present it.

    imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;

    [self presentViewController:imagePickerVC animated:YES completion:nil];
}

- (IBAction)takePhoto:(id)sender {
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    
    // The Xcode simulator does not support taking pictures, so let's first check that the camera is indeed supported on the device before trying to present it.
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else {
        NSLog(@"Camera 🚫 available so we will use photo library instead");
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    [self presentViewController:imagePickerVC animated:YES completion:nil];
}

- (PFFileObject *)getPFFileFromImage: (UIImage * _Nullable)image {

    // check if image is not nil
    if (!image) {
        return nil;
    }

    NSData *imageData = UIImagePNGRepresentation(image);
    // get image data and check if that is not nil
    if (!imageData) {
        return nil;
    }

    return [PFFileObject fileObjectWithName:@"image.png" data:imageData];
}

- (void)createTimeline {
    // construct PFQuery
    PFQuery *postQuery = [Post query];
    [postQuery orderByDescending:@"createdAt"];
    [postQuery includeKey:@"author"];
    [postQuery whereKey: @"author" equalTo:PFUser.currentUser];
    postQuery.limit = 20;
    
    // fetch data asynchronously
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray<Post *> * _Nullable posts, NSError * _Nullable error) {
        if (posts) {
            self.arrayOfPosts = (NSMutableArray *)posts;
            [self.pfpTableView reloadData];
        }
        else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
    }];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    InstagramCell *cell = [tableView dequeueReusableCellWithIdentifier:@"customCell" forIndexPath:indexPath];
    Post *post = self.arrayOfPosts[indexPath.row];
    [post.image getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
        UIImage *image = [UIImage imageWithData:data];
        cell.profilePost.image = image;
    }];
    
    NSDate *dateForm = post.createdAt;
    NSString *dateString = dateForm.timeAgoSinceNow;
    
    cell.profileDate.text = dateString;
    
    NSString *username = [@"@" stringByAppendingString: post.author.username];
    cell.profileUsername.text = username;
    
    NSString *space = @"  ";
    NSString *usernameCaption = [username stringByAppendingString: space];
    NSString *fullCaption = [usernameCaption stringByAppendingString: self.arrayOfPosts[indexPath.row][@"caption"]];

    NSMutableAttributedString *boldedString = [[NSMutableAttributedString alloc] initWithString:fullCaption];
    NSRange boldRange = [fullCaption rangeOfString:usernameCaption];
    [boldedString addAttribute: NSFontAttributeName value:[UIFont boldSystemFontOfSize:17] range:boldRange];
    [cell.profileCaption setAttributedText: boldedString];
    
    PFUser *user = PFUser.currentUser;
    cell.profilePfp.file = user[@"profilePicture"];
    
    cell.profilePfp.layer.cornerRadius = 21;
    cell.profilePfp.layer.masksToBounds = YES;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
    
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayOfPosts.count;
}

@end
