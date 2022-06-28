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
@property (strong, nonatomic) Post *post;

@end

NS_ASSUME_NONNULL_END
