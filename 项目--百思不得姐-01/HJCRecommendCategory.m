//
//  HJCRecommendCategory.m
//  项目--百思不得姐-01
//
//  Created by 贺吉辰 on 18/3/16.
//  Copyright © 2016年 贺吉辰. All rights reserved.
//

#import "HJCRecommendCategory.h"

@implementation HJCRecommendCategory

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"ID" : @"id"
             };
}

- (NSMutableArray *)users {
    if (_users == nil) {
        _users = [NSMutableArray array];
    }
    return _users;
}

@end
