//
//  HJCTopicVideoView.m
//  项目--百思不得姐-01
//
//  Created by 贺吉辰 on 27/3/16.
//  Copyright © 2016年 贺吉辰. All rights reserved.
//

#import "HJCTopicVideoView.h"
#import "HJCTopic.h"

#import <UIImageView+WebCache.h>

@interface HJCTopicVideoView ()

@property (nonatomic, weak) IBOutlet UILabel *videotimeLabel;

@property (nonatomic, weak) IBOutlet UILabel *palycountLabel;

@property (nonatomic, weak) IBOutlet UIImageView *imageView;


@end

@implementation HJCTopicVideoView

- (void)awakeFromNib {
    self.autoresizingMask = UIViewAutoresizingNone;
}

+ (instancetype)videoView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

- (void)setTopic:(HJCTopic *)topic {
    _topic = topic;
    
    self.palycountLabel.text = [NSString stringWithFormat:@"%@次播放",topic.playcount];
    
    
    NSInteger minute = [topic.videotime integerValue] / 60;
    NSInteger second = [topic.videotime integerValue] % 60;
    self.videotimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",minute,second];
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    
}

@end
