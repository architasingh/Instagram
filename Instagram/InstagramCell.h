//
//  InstagramCell.h
//  Instagram
//
//  Created by Archita Singh on 6/28/22.
//

#import <UIKit/UIKit.h>
#import "Post.h"

@import Parse;

NS_ASSUME_NONNULL_BEGIN

@interface InstagramCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *postImage;
@property (weak, nonatomic) IBOutlet UILabel *postCaption;
@property (weak, nonatomic) IBOutlet UILabel *postDate;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UIImageView *profilePic;

@property (weak, nonatomic) IBOutlet PFImageView *profilePost;
@property (weak, nonatomic) IBOutlet UILabel *profileUsername;
@property (weak, nonatomic) IBOutlet UIImageView *profilepfp;
@property (weak, nonatomic) IBOutlet UILabel *profileDate;
@property (weak, nonatomic) IBOutlet UILabel *profileCaption;

@property (strong, nonatomic) Post *post;

@end

NS_ASSUME_NONNULL_END
