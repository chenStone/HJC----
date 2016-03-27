//
//  HJCShowPictureViewController.m
//  项目--百思不得姐-01
//
//  Created by 贺吉辰 on 25/3/16.
//  Copyright © 2016年 贺吉辰. All rights reserved.
//

#import "HJCShowPictureViewController.h"
#import "HJCTopic.h"
#import "UIView+Extension.h"
#import "HJCProgressView.h"

#import <UIImageView+WebCache.h>
#import <SVProgressHUD.h>

@interface HJCShowPictureViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, weak) UIImageView *imageView;
@property (weak, nonatomic) IBOutlet HJCProgressView *progressView;

@end

@implementation HJCShowPictureViewController

- (void)viewDidLoad {
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    
    // 将图片加入到scollView中
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back)]];
    self.imageView = imageView;
    [self.scrollView addSubview:imageView];
    
    CGFloat imageW = screenW;
    CGFloat imageH = imageW * self.topic.height / self.topic.width;
    if (imageH > screenH) { // 图片高度大于屏幕大小
        imageView.frame = CGRectMake(0, 0, imageW, imageH);
        self.scrollView.contentSize = CGSizeMake(0, imageH);
    } else { // 图片高度小于屏幕大小
        imageView.size = CGSizeMake(imageW, imageH);
        imageView.centerY = screenH * 0.5;
        imageView.x = 0;
    }
    
    // 取出这个模型中的进度
    self.progressView.progress = self.topic.progress;
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        self.topic.progress = 1.0 * receivedSize / expectedSize;
        [self.progressView setProgress:self.topic.progress];
        
        self.progressView.hidden = NO;
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        self.progressView.hidden = YES;
    }];
    
}

#pragma mark - 点击返回按钮
- (IBAction)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)save {
    
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败"];
    }else {
        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
    }
    
    
}
@end
