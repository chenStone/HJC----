//
//  HJCRecommendCategory.h
//  项目--百思不得姐-01
//
//  Created by 贺吉辰 on 18/3/16.
//  Copyright © 2016年 贺吉辰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HJCRecommendCategory : NSObject

/** id */
@property (nonatomic, assign) NSInteger ID;
/** 总数 */
@property (nonatomic, assign) NSInteger count;
/** 名字 */
@property (nonatomic, copy) NSString *name;

/** 这个类别的用户数据 */
@property (nonatomic, strong) NSMutableArray *users;
/** 是否需要刷洗 */
@property (nonatomic, assign, getter = isRefresh) BOOL refresh;
/** 总数 */
@property (nonatomic, assign) NSInteger total;
/** 当前页 */
@property (nonatomic, assign) NSInteger currentPage;

@end
