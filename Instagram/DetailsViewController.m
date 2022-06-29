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
    
    self.caption.text = self.post[@"caption"];
    
    NSDate *dateForm = self.post.createdAt;
    NSString *dateString = dateForm.shortTimeAgoSinceNow;
    
    /*NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"E MMM d HH:mm:ss Z y";
    
    // Configure output format
    formatter.dateStyle = NSDateFormatterShortStyle;
    formatter.timeStyle = NSDateFormatterNoStyle;
    
    // Convert Date to String
    NSString *dateString = [formatter stringFromDate:dateForm];*/
    
    self.date.text = dateString;
    
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
