//
//  HJCTopic.m
//  项目--百思不得姐-01
//
//  Created by 贺吉辰 on 21/3/16.
//  Copyright © 2016年 贺吉辰. All rights reserved.
//

#import "HJCTopic.h"
#import "NSDate+Extension.h"
#import "HJCConst.h"
#import "HJCComment.h"
#import "HJCUser.h"

//#import <MJExtension.h>


#define HJCScreenW [UIScreen mainScreen].bounds.size.width
@implementation HJCTopic {
    CGFloat _topicCellHeight;
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"small_image" : @"image0",
             @"large_image" : @"image1",
             @"normal_image" : @"image2",
             @"ID" : @"id"
             
             };
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"top_cmt" : @"HJCComment"};
}

- (NSString *)create_time {
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *createDate = [fmt dateFromString:_create_time];
    NSDate *now = [NSDate date];

    if ([createDate isThisYear]) { // 是今年
        
        if (createDate.isToday) { // 是今天
            NSDateComponents *comp = [now deltaFrom:createDate];
            if (comp.hour >= 1) {  // 时间差距 >= 1小时
                return [NSString stringWithFormat:@"%ld小时前", comp.hour];
            } else if (comp.minute >= 1) { // 时间差距打野一小时
                return [NSString stringWithFormat:@"%ld分钟前",comp.minute];
            } else {
                return @"刚刚";
            }
        } else if (createDate.isYesterday) { //是昨天
            fmt.dateFormat = @"昨天 HH:mm:ss";
            return [fmt stringFromDate:createDate];
        } else { // 前天~一年内
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt stringFromDate:createDate];
        }
    } else { // 非今年
        return _create_time;
    }
}

- (CGFloat)topicCellHeight {
    
    if (!_topicCellHeight) {
        // 文字的最大尺寸
        CGSize maxSize = CGSizeMake(HJCScreenW - 2 * HJCTopicCellMargin, MAXFLOAT);
        // 计算文字的高度
        CGFloat textH = [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.height;
        // cell的高度
        _topicCellHeight = HJCTopicCellTextY + textH + HJCTopicCellMargin;
        
        if (self.type == HJCTopicTypePicture) {
            CGFloat pictureW = maxSize.width;
            CGFloat pictureH = self.height * pictureW / self.width;
            if (self.height >= HJCTopicCellPictureMaxH) {
                pictureH = HJCTopicCellPictureFixedH;
            }
            _pictureViewFrame = CGRectMake(HJCTopicCellMargin, _topicCellHeight, pictureW, pictureH);
            _topicCellHeight += pictureH + HJCTopicCellMargin;
        } else if (self.type == HJCTopicTypeVoice) {
            CGFloat voiceW = maxSize.width;
            CGFloat voiceH = self.height * voiceW / self.width;
            CGFloat voiceX = HJCTopicCellMargin;
            CGFloat voiceY = _topicCellHeight;
            _voiceViewFrame = CGRectMake(voiceX, voiceY, voiceW, voiceH);
            _topicCellHeight += voiceH + HJCTopicCellMargin;
        } else if (self.type == HJCTopicTypeVideo) {
            CGFloat videoW = maxSize.width;
            CGFloat videoH = self.height * videoW / self.width;
            CGFloat videoX = HJCTopicCellMargin;
            CGFloat videoY = _topicCellHeight;
            _videoViewFrame = CGRectMake(videoX, videoY, videoW, videoH);
            _topicCellHeight += videoH + HJCTopicCellMargin;
        }
        
        HJCComment *topcmt = [self.top_cmt firstObject];
        if (topcmt) {
            NSString *content = [NSString stringWithFormat:@"%@:%@",topcmt.user.username, topcmt.content];
            CGSize contentMaxSize = CGSizeMake(HJCScreenW - 2 * HJCTopicCellMargin, MAXFLOAT);
            CGFloat contentH = [content boundingRectWithSize:contentMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.height;
            
            _topicCellHeight += HJCTopicCellMargin + contentH + HJCTopicCellTopcmdTitleLabelH;
        }
        
        _topicCellHeight += HJCTopicCellBottomBarH + HJCTopicCellMargin;
    }
    return _topicCellHeight;
    
}

@end
