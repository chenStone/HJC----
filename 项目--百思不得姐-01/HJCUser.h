//
//  HJCUser.h
//  项目--百思不得姐-01
//
//  Created by 贺吉辰 on 27/3/16.
//  Copyright © 2016年 贺吉辰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HJCUser : NSObject

/** 昵称 */
@property (nonatomic, strong) NSString *username;

/** 性别 */
@property (nonatomic, strong) NSString *sex;

/** 头像 */
@property (nonatomic, strong) NSString *profile_image;

@end
