//
//  HJCComment.h
//  项目--百思不得姐-01
//
//  Created by 贺吉辰 on 27/3/16.
//  Copyright © 2016年 贺吉辰. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HJCUser;
@interface HJCComment : NSObject

/** 用户 */
@property (nonatomic, strong) HJCUser *user;
/** 评论的文字内容 */
@property (nonatomic, copy) NSString *content;
/** 音频文件的时长 */
@property (nonatomic, assign) NSInteger voicetime;
/** 音频文件的路径 */
@property (nonatomic, copy) NSString *voiceuri;
/** 被点赞的数量 */
@property (nonatomic, assign) NSInteger like_count;

@end
