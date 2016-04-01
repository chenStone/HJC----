//
//  HJCCommentCell.m
//  项目--百思不得姐-01
//
//  Created by 贺吉辰 on 30/3/16.
//  Copyright © 2016年 贺吉辰. All rights reserved.
//

#import "HJCCommentCell.h"
#import "HJCComment.h"
#import "HJCUser.h"
#import "HJCConst.h"
#import "UIImage+HJCExtension.h"

#import <UIImageView+WebCache.h>

@interface HJCCommentCell ()
/** 头像View */
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
/** 性别View */
@property (weak, nonatomic) IBOutlet UIImageView *sexImageView;
/** 昵称Label */
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
/** 内容Label */
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
/** 点击数Label */
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;
/** 音频按钮 */
@property (weak, nonatomic) IBOutlet UIButton *voiceButton;

@end

@implementation HJCCommentCell

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    return NO;
}

- (void)setComment:(HJCComment *)comment {
    _comment = comment;
    
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:comment.user.profile_image] placeholderImage:[[UIImage imageNamed: @"defaultUserIcon"] circleImage] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.profileImageView.image = [image circleImage];
    }];
    
    self.sexImageView.image = [comment.user.sex isEqualToString: HJCUserSexMale]?[UIImage imageNamed:@"Profile_manIcon"] : [UIImage imageNamed:@"Profile_womanIcon"] ;
    
    self.usernameLabel.text = comment.user.username;
    
    self.likeCountLabel.text = [NSString stringWithFormat:@"%ld",comment.like_count];
    
    self.contentLabel.text = comment.content;

    if (comment.voiceuri.length) {
        [self.voiceButton setTitle:[NSString stringWithFormat:@"%ld''",comment.voicetime] forState:UIControlStateNormal];
        self.voiceButton.hidden = NO;
    } else {
        self.voiceButton.hidden = YES;
    }
}

@end
