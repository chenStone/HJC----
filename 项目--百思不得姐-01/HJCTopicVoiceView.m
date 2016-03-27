//
//  HJCTopicVoiceView.m
//  项目--百思不得姐-01
//
//  Created by 贺吉辰 on 27/3/16.
//  Copyright © 2016年 贺吉辰. All rights reserved.
//

#import "HJCTopicVoiceView.h"
#import "HJCTopic.h"

#import <UIImageView+WebCache.h>

@interface HJCTopicVoiceView ()
/** 播放时长 */
@property (weak, nonatomic) IBOutlet UILabel *voicetimeLabel;
/** 播放次数 */
@property (nonatomic, weak) IBOutlet UILabel *playcountLabel;
/** 音频图片 */
@property (nonatomic, weak) IBOutlet UIImageView *imageView;

@end

@implementation HJCTopicVoiceView

- (void)awakeFromNib {
    self.autoresizingMask = UIViewAutoresizingNone;
}

+ (instancetype)voiceView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

- (void)setTopic:(HJCTopic *)topic {
    _topic = topic;
    
    // 设置音频时长
    NSInteger minute = [topic.voicetime integerValue] / 60;
    NSInteger second = [topic.voicetime integerValue] % 60;
    self.voicetimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",minute,second];
    
    // 设置音频的播放次数
    self.playcountLabel.text = [NSString stringWithFormat:@"%@次播放",topic.playcount];
    
    // 设置图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
}

@end
