//
//  ProfileViewController.h
//  Instagram
//
//  Created by Archita Singh on 6/29/22.
//

#import <UIKit/UIKit.h>
#import "Post.h"
#import "PFImageView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProfileViewController : UIViewController
@property (weak, nonatomic) IBOutlet PFImageView *profilePic;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UIButton *takePic;
@property (weak, nonatomic) IBOutlet UIButton *pickfromCam;

@end

NS_ASSUME_NONNULL_END
