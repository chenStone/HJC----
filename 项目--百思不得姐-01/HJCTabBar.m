//
//  HJCTabBar.m
//  项目--百思不得姐-01
//
//  Created by 贺吉辰 on 18/3/16.
//  Copyright © 2016年 贺吉辰. All rights reserved.
//

#import "HJCTabBar.h"
#import "UIView+Extension.h"
#import "HJCPublishView.h"

@interface HJCTabBar ()

@property (nonatomic, weak) UIButton *publishBtn;
@end

@implementation HJCTabBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // 设置tabBar的背景图颜色
        self.backgroundImage = [UIImage imageNamed:@"tabbar-light"];
        
        // 添加按钮
        UIButton *publishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [publishBtn setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishBtn setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [publishBtn sizeToFit];
        [publishBtn addTarget:self action:@selector(publish) forControlEvents:UIControlEventTouchUpInside];
        self.publishBtn = publishBtn;
        [self addSubview:publishBtn];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 设置按钮的位置
    self.publishBtn.center = CGPointMake(self.width * 0.5, self.height * 0.5);
    
    CGFloat buttonW = self.width / 5;
    CGFloat buttonH = self.height;
    CGFloat buttonY = 0;
    
    // 设置UITabBarButton按钮的位置
    NSInteger index = 0;
    for (UIView *button in self.subviews) {
        if (![button isKindOfClass:NSClassFromString(@"UITabBarButton")]) continue;
        
        if (index == 2) {
            index ++;
        }
        
        CGFloat buttonX = index * buttonW;
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        index ++;
    }
}

#pragma mark - 按钮点击方法
- (void)publish {
    HJCPublishView *publishView = [HJCPublishView publishView];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    publishView.frame = window.bounds;
    [window addSubview:publishView];
                                   
}


@end
