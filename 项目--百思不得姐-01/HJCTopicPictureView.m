//
//  HJCPictureView.m
//  项目--百思不得姐-01
//
//  Created by 贺吉辰 on 24/3/16.
//  Copyright © 2016年 贺吉辰. All rights reserved.
//

#import "HJCTopicPictureView.h"
#import "HJCTopic.h"
#import "HJCConst.h"
#import "HJCShowPictureViewController.h"
#import "HJCProgressView.h"

#import <UIImageView+WebCache.h>

@interface HJCTopicPictureView ()
/** 进度条 */
@property (weak, nonatomic) IBOutlet  HJCProgressView *progressView;
/** 图片 */
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
/** GIF图标 */
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
/** 点击查看大图 */
@property (weak, nonatomic) IBOutlet UIButton *seeBigPictureBtn;
@end

@implementation HJCTopicPictureView

- (void)awakeFromNib {
    
    // 给图片添加监听器
    self.autoresizingMask = UIViewAutoresizingNone;
    
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPicture)]];
}

#pragma mark - 图片点击按钮
- (void)showPicture {
    HJCShowPictureViewController *showVc = [[HJCShowPictureViewController alloc] init];
    showVc.topic = self.topic;
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showVc animated:YES completion:nil];
    
}

+ (instancetype)pictureView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

- (void)setTopic:(HJCTopic *)topic {
    _topic = topic;
    
    self.progressView.progress = topic.progress;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        topic.progress = 1.0 * receivedSize / expectedSize;
        [self.progressView setProgress:topic.progress];
        
        self.progressView.hidden = NO;
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
        
        if (!(topic.height >= HJCTopicCellPictureMaxH)) return; // 是小图
        
        // 开启图形上下文
        UIGraphicsBeginImageContextWithOptions(topic.pictureViewFrame.size, YES, 0);
        
        CGFloat width = topic.pictureViewFrame.size.width;
        CGFloat height = width * topic.height / topic.width;
        [image drawInRect:CGRectMake(0, 0, width, height)];
        
        // 得到图片
        self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
        // 关闭图形上下文
        UIGraphicsEndImageContext();
        
    }];
    
    self.gifView.hidden = !([topic.is_gif integerValue] == 1);
    
    if (topic.height >= HJCTopicCellPictureMaxH) {
        self.seeBigPictureBtn.hidden = NO;
    } else {
        self.seeBigPictureBtn.hidden = YES;
    }
}


@end
