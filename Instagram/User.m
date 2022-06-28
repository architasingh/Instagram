//
//  User.m
//  Instagram
//
//  Created by Archita Singh on 6/28/22.
//

#import "User.h"

@implementation User
- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];

    if (self) {
        self.name = dictionary[@"name"];
        self.screenName = dictionary[@"screen_name"];
        self.profilePicture = dictionary[@"profile_image_url_https"];
    // Initialize any other properties
    }
    return self;
}
@end
