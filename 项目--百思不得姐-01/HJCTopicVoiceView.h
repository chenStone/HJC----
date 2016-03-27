//
//  HJCTopicVoiceView.h
//  项目--百思不得姐-01
//
//  Created by 贺吉辰 on 27/3/16.
//  Copyright © 2016年 贺吉辰. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HJCTopic;
@interface HJCTopicVoiceView : UIView

@property (nonatomic, strong) HJCTopic *topic;

+ (instancetype)voiceView;

@end
