//
//  DetailsViewController.h
//  Instagram
//
//  Created by Archita Singh on 6/28/22.
//

#import <UIKit/UIKit.h>
#import "Post.h"
#import "PFImageView.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *caption;
@property (weak, nonatomic) IBOutlet PFImageView *postImage;
@property (strong, nonatomic) Post *post;
@property (weak, nonatomic) IBOutlet UILabel *username;

@end

NS_ASSUME_NONNULL_END
