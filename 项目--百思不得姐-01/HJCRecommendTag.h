//
//  HJCRecommendTag.h
//  项目--百思不得姐-01
//
//  Created by 贺吉辰 on 19/3/16.
//  Copyright © 2016年 贺吉辰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HJCRecommendTag : NSObject

// 标签名称
@property (nonatomic, copy) NSString *theme_name;
// 标签url
@property (nonatomic, copy) NSString *image_list;
// 关注数
@property (nonatomic, assign) NSInteger sub_number;

@end
