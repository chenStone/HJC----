//
//  NSDate+Extension.h
//  项目--百思不得姐-01
//
//  Created by 贺吉辰 on 22/3/16.
//  Copyright © 2016年 贺吉辰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)

/** 对两个时间进行比较 */
- (NSDateComponents *)deltaFrom:(NSDate *)from;
/** 是否是今年 */
- (BOOL)isThisYear;
/** 是否是今天 */
- (BOOL)isToday;
/** 是否是昨天 */
- (BOOL)isYesterday;

@end
