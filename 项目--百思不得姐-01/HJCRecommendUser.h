//
//  HJCRecommendUser.h
//  项目--百思不得姐-01
//
//  Created by 贺吉辰 on 19/3/16.
//  Copyright © 2016年 贺吉辰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MJRefresh.h>

@interface HJCRecommendUser : NSObject
/** 用户名称 */
@property (nonatomic, copy) NSString *screen_name;
/** 粉丝数量 */
@property (nonatomic ,assign) NSInteger fans_count;
/** 图片的url */
@property (nonatomic, copy) NSString *header;

@end
