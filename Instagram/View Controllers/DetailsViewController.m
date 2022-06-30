//
//  DetailsViewController.m
//  Instagram
//
//  Created by Archita Singh on 6/28/22.
//

# import "DetailsViewController.h"
# import "DateTools.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.post.image getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
        UIImage *image = [UIImage imageWithData:data];
        self.postImage.image = image;
    }];
        
    NSDate *dateForm = self.post.createdAt;
    NSString *dateString = dateForm.timeAgoSinceNow;
    
    self.date.text = dateString;
    
    NSString *username = [@"@" stringByAppendingString: self.post.author.username];
    self.username.text = username;
    
    NSString *space = @"  ";
    NSString *usernameCaption = [username stringByAppendingString: space];
    NSString *fullCaption = [usernameCaption stringByAppendingString: self.post[@"caption"]];

    NSMutableAttributedString *boldedString = [[NSMutableAttributedString alloc] initWithString:fullCaption];
    NSRange boldRange = [fullCaption rangeOfString:usernameCaption];
    [boldedString addAttribute: NSFontAttributeName value:[UIFont boldSystemFontOfSize:17] range:boldRange];
    [self.caption setAttributedText: boldedString];
    
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
