//
//  HJCPublishView.m
//  项目--百思不得姐-01
//
//  Created by 贺吉辰 on 26/3/16.
//  Copyright © 2016年 贺吉辰. All rights reserved.
//

#import "HJCPublishView.h"
#import "UIView+Extension.h"
#import "HJCVerticalButton.h"
#import "HJCPostWordViewController.h"
#import "HJCNavigationController.h"

#import <POP.h>

#define HJCScreenW [UIScreen mainScreen].bounds.size.width
#define HJCScreenH [UIScreen mainScreen].bounds.size.height
@interface HJCPublishView ()

@end

@implementation HJCPublishView

#pragma mark -初始化
+ (instancetype)publishView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

- (void)awakeFromNib {
    [UIApplication sharedApplication].keyWindow.rootViewController.view.userInteractionEnabled = NO;
    self.userInteractionEnabled = YES;
    
    // 按钮的图形数组
    NSArray *images  = @[@"publish-video",@"publish-picture",@"publish-text",@"publish-audio",@"publish-review",@"publish-offline"];
    NSArray *titles = @[@"发视频",@"发图片",@"发段子",@"发声音",@"审贴",@"发链接" ];
    
    // 添加按钮
    CGFloat buttonW = 75;
    CGFloat buttonH = buttonW + 30;
    CGFloat buttonStartX = 10;
    CGFloat buttonStartY = (HJCScreenH - 2 * buttonH) * 0.5;
    NSInteger maxCols = 3;
    CGFloat marginX = ((HJCScreenW - 2 * buttonStartX) - 3 * buttonW) / (maxCols-1);
    
    for (NSInteger i = 0; i < 6; i++) {
        // 设置内容
        HJCVerticalButton *button = [HJCVerticalButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        // 计算X\Y
        NSInteger col = i % maxCols;
        NSInteger row = i / maxCols;
        CGFloat buttonX = buttonStartX +  col * (buttonW + marginX);
        CGFloat buttonEndY = row * buttonH + buttonStartY;
        CGFloat buttonBeginY = buttonEndY - HJCScreenH;
        [self addSubview:button];
        
        // 添加动画
        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        anim.fromValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonBeginY, buttonW, buttonH)];
        anim.toValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonEndY, buttonW, buttonH)];
        anim.springSpeed = 10;
        anim.springBounciness = 10;
        anim.beginTime = CACurrentMediaTime() + 0.1 * i;
        
        [button pop_addAnimation:anim forKey:nil];
    }
    
    // 添加app_sloganView
    UIImageView *appSloganView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_slogan"]];
    CGFloat centerEndY = HJCScreenH * 0.2;
    CGFloat centerX = HJCScreenW * 0.5;
    CGFloat centerBeginY = centerEndY - HJCScreenH;
    [self addSubview:appSloganView];
    
    // 添加动画
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    anim.fromValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerBeginY)];
    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerEndY)];
    anim.springSpeed = 10;
    anim.springBounciness = 10;
    anim.beginTime = CACurrentMediaTime() + titles.count * 0.1;
    anim.completionBlock = ^(POPAnimation *anim, BOOL finished){
        self.userInteractionEnabled = YES;
        [UIApplication sharedApplication].keyWindow.rootViewController.view.userInteractionEnabled = YES;
    };
    [appSloganView pop_addAnimation:anim forKey:nil];
    
    
}


#pragma mark - 点击取消按钮
- (IBAction)cancel {
    [self cancelWithCompletionBlock:nil];
    
}

#pragma mark - 触摸屏幕
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self cancelWithCompletionBlock:nil];
}

- (void)cancelWithCompletionBlock:(void (^)())completionBlock {
    
    [UIApplication sharedApplication].keyWindow.rootViewController.view.userInteractionEnabled = NO;
    self.userInteractionEnabled = NO;
    
    NSInteger beginCount = 2;
    for (NSInteger i = beginCount; i < self.subviews.count; i++) {
        UIView *subView = self.subviews[i];
        POPBasicAnimation * anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
        anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        CGFloat centerY = subView.centerY + HJCScreenH;
        anim.toValue = [NSValue valueWithCGPoint:CGPointMake(subView.centerX, centerY)];
        anim.beginTime = CACurrentMediaTime() + (i - beginCount) * 0.1;
        [subView pop_addAnimation:anim forKey:nil];
        
        if (i == self.subviews.count - 1) {
            anim.completionBlock = ^(POPAnimation *anim, BOOL finished){
                [self removeFromSuperview];
                
                if (completionBlock) {
                    completionBlock();
                }
                
                [UIApplication sharedApplication].keyWindow.rootViewController.view.userInteractionEnabled = YES;
                self.userInteractionEnabled = YES;
            };
        }
    }
}

#pragma mark - 点击相应按钮的方法
- (void)btnClick:(UIButton *)btn {
    [self cancelWithCompletionBlock:^{
        NSLog(@"%@",btn.titleLabel.text);
        
        if ([btn.titleLabel.text isEqualToString:@"发段子"]) {
            HJCPostWordViewController *postwordVc = [[HJCPostWordViewController alloc] init];
            
            HJCNavigationController *nav = [[HJCNavigationController alloc] initWithRootViewController:postwordVc];
            
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:nil];
            
        }
    }];
}

@end
