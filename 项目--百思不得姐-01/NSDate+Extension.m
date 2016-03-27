//
//  NSDate+Extension.m
//  项目--百思不得姐-01
//
//  Created by 贺吉辰 on 22/3/16.
//  Copyright © 2016年 贺吉辰. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)

- (NSDateComponents *)deltaFrom:(NSDate *)from {
    // 日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // 比较时间
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    return [calendar components:unit fromDate:from toDate:self options:kNilOptions];
}

- (BOOL)isThisYear {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSInteger nowYear = [calendar component:NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger selfYear = [calendar component:NSCalendarUnitYear fromDate:self];
    return (nowYear == selfYear);
}

//- (BOOL)isToday {
//    NSCalendar *calendar = [NSCalendar currentCalendar];
//    
//    NSCalendarUnit unit = NSCalendarUnitYear |NSCalendarUnitMonth |NSCalendarUnitDay;
//    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
//    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
//    return nowCmps.year == selfCmps.year && nowCmps.month == selfCmps.month && nowCmps.day == selfCmps.day;
//}

- (BOOL)isToday {
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSString *nowString = [fmt stringFromDate:[NSDate date]];
    NSString *selfString = [fmt stringFromDate:self];
    
    return [nowString isEqualToString:selfString];
}

- (BOOL)isYesterday {
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSDate *nowDate = [fmt dateFromString:[fmt stringFromDate:[NSDate date]]];
    NSDate *selfDate = [fmt dateFromString:[fmt stringFromDate:self]];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
    NSDateComponents *components = [calendar components:unit fromDate:selfDate toDate:nowDate options:0];
    return components.year == 0 && components.month == 0 && components.day == 1;
}

@end
