//
//  HJCTopicCell.m
//  项目--百思不得姐-01
//
//  Created by 贺吉辰 on 22/3/16.
//  Copyright © 2016年 贺吉辰. All rights reserved.
//

#import "HJCTopicCell.h"
#import "HJCTopic.h"
#import "UIView+Extension.h"
#import "NSDate+Extension.h"
#import "HJCConst.h"
#import "HJCTopicPictureView.h"
#import "HJCTopicVoiceView.h"
#import "HJCTopicVideoView.h"

#import <UIImageView+WebCache.h>

@interface HJCTopicCell ()
/** 头像imageView */
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
/** 昵称label */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/** 发表时间label */
@property (weak, nonatomic) IBOutlet UILabel *createTimeLabel;
/** 顶 */
@property (weak, nonatomic) IBOutlet UIButton *dingBtn;
/** 踩 */
@property (weak, nonatomic) IBOutlet UIButton *caiBtn;
/** 转发 */
@property (weak, nonatomic) IBOutlet UIButton *repostBtn;
/** 评论 */
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
/** 内容 */
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

/** 图片View  */
@property (nonatomic, weak) HJCTopicPictureView *pictureView;
/** 音频View  */
@property (nonatomic, weak) HJCTopicVoiceView *voiceView;
/** 视屏View */
@property (nonatomic, weak) HJCTopicVideoView *videoView;

@end

@implementation HJCTopicCell


#pragma mark - 懒加载
- (HJCTopicPictureView *)pictureView {
    if (_pictureView == nil) {
        HJCTopicPictureView *pictureView = [HJCTopicPictureView pictureView];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}

- (HJCTopicVoiceView *)voiceView {
    if (_voiceView == nil) {
        HJCTopicVoiceView *voiceView = [HJCTopicVoiceView voiceView];
        [self.contentView addSubview:voiceView];
        _voiceView = voiceView;
    }
    return _voiceView;
}

- (HJCTopicVideoView *)videoView {
    if (_videoView == nil) {
        HJCTopicVideoView *videoView = [HJCTopicVideoView videoView];
        [self.contentView addSubview:videoView];
        _videoView = videoView;
    }
    return _videoView;
}


#pragma mark - 初始化
- (void)awakeFromNib {
    
    self.translatesAutoresizingMaskIntoConstraints = YES;
}

- (void)setTopic:(HJCTopic *)topic {
    _topic = topic;
    
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed: @"defaultUserIcon"]];
    self.nameLabel.text = topic.name;
    
    // 时间
    self.createTimeLabel.text = topic.create_time;
    // 顶数量的判断
    [self setupButtonTitle:self.dingBtn count:topic.ding placeholder:@"赞"];
    // 踩数量的判断
    [self setupButtonTitle:self.caiBtn count:topic.cai placeholder:@"踩"];
    // 分享的判断
    [self setupButtonTitle:self.repostBtn count:topic.repost placeholder:@"分享"];
    // 评论的判断
    [self setupButtonTitle:self.commentBtn count:topic.comment placeholder:@"评论"];
    // 内容
    self.contentLabel.text = topic.text;
    
    if (topic.type == HJCTopicTypePicture) { //  图片帖子
        self.pictureView.hidden = NO;
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
        self.pictureView.topic = topic;
        self.pictureView.frame = topic.pictureViewFrame;
    } else if (topic.type == HJCTopicTypeVoice) { //  音频帖子
        self.voiceView.hidden = NO;
        self.videoView.hidden = YES;
        self.pictureView.hidden = YES;
        self.voiceView.topic = topic;
        self.voiceView.frame = topic.voiceViewFrame;
    } else if (topic.type == HJCTopicTypeVideo) { // 视频帖子
        self.videoView.hidden = NO;
        self.voiceView.hidden = YES;
        self.pictureView.hidden = YES;
        self.videoView.topic = topic;
        self.videoView.frame = topic.videoViewFrame;
    } else { // 是段子
        self.pictureView.hidden = YES;
        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;
    }
}

/**
 *  判断标题的显示
 */
- (void)setupButtonTitle:(UIButton *)button count:(NSInteger)count placeholder:(NSString *)placeholder {
    if (count >= 10000) {
        placeholder = [NSString stringWithFormat:@"%0.1lf万",count / 10000.0];
    } else if (count > 0) {
        placeholder = [NSString stringWithFormat:@"%ld",count];
    }
    [button setTitle:placeholder forState:UIControlStateNormal];
    
}
    
- (void)setFrame:(CGRect)frame {
    frame.size.height -=  HJCTopicCellMargin;
    [super setFrame:frame];
    
}

@end
