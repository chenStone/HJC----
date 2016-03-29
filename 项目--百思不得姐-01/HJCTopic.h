//
//  HJCTopic.h
//  项目--百思不得姐-01
//
//  Created by 贺吉辰 on 21/3/16.
//  Copyright © 2016年 贺吉辰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJCConst.h"

@interface HJCTopic : NSObject

@property (nonatomic, copy) NSString *ID;
/** 名称 */
@property (nonatomic, copy) NSString *name;
/** 头像 */
@property (nonatomic, copy) NSString *profile_image;
/** 发帖时间 */
@property (nonatomic, copy) NSString *create_time;
/** 文字内容 */
@property (nonatomic, copy) NSString *text;
/** 顶的数量 */
@property (nonatomic, assign) NSInteger ding;
/** 踩的数量 */
@property (nonatomic, assign) NSInteger cai;
/** 转发的数量 */
@property (nonatomic, assign) NSInteger repost;
/** 评论的数量 */
@property (nonatomic, assign) NSInteger comment;
/** 是否是GIF */
@property (nonatomic, copy) NSString *is_gif;
/** 图片的宽度 */
@property (nonatomic, assign) CGFloat width;
/** 图片的高度 */
@property (nonatomic, assign) CGFloat height;
/** 小图的URL */
@property (nonatomic, copy) NSString *small_image;
/** 中图的URL */
@property (nonatomic, copy) NSString * normal_image;
/** 大图的URL */
@property (nonatomic, copy) NSString * large_image;
/** 数据的类型 */
@property (nonatomic, assign) HJCTopicType type;
/** 音频时长 */
@property (nonatomic, copy) NSString *voicetime;
/** 播放次数 */
@property (nonatomic, copy) NSString *playcount;
/** 视频时长 */
@property (nonatomic, copy) NSString *videotime;
/** 最热评论（存放着HJCComment模型） */
@property (nonatomic, copy) NSArray *top_cmt;



/********** 额外的辅助属性 **********/
/** cell的高度 */
@property (nonatomic, assign, readonly) CGFloat topicCellHeight;
/** cell中picture的Frame */
@property (nonatomic, assign, readonly) CGRect pictureViewFrame;
/** 图片的进度 */
@property (nonatomic, assign) CGFloat progress;

/** cell中voice的Frame */
@property (nonatomic, assign, readonly) CGRect voiceViewFrame;
/** cell中video的Frame */
@property (nonatomic, assign, readonly) CGRect videoViewFrame;



@end
