//
//  HJCMeViewController.m
//  项目--百思不得姐-01
//
//  Created by 贺吉辰 on 18/3/16.
//  Copyright © 2016年 贺吉辰. All rights reserved.
//

#import "HJCMeViewController.h"
#import "UIBarButtonItem+Extension.h"

@interface HJCMeViewController ()

@end

@implementation HJCMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航栏标题栏内容
    self.navigationItem.title = @"我的";
    
    // 设置导航栏右边按钮的内容
    self.navigationItem.rightBarButtonItems = @[[UIBarButtonItem buttonItemWithImage:@"mine-setting-icon" highImage:@"mine-setting-icon-click" target:self action:@selector(settingClick)],[UIBarButtonItem buttonItemWithImage:@"mine-moon-icon" highImage:@"mine-moon-icon-click" target:self action:@selector(moonClick)]];
    
    // 设置背景颜色
    self.view.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0  blue:243/255.0  alpha:1.0];
    
}

#pragma mark - 点击leftBtn的方法
- (void)moonClick {
    NSLog(@"%s被点击了",__func__);
}

- (void)settingClick {
    NSLog(@"%s被点击了",__func__);
}

@end
