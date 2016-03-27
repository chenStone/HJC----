//
//  HJCNewViewController.m
//  项目--百思不得姐-01
//
//  Created by 贺吉辰 on 18/3/16.
//  Copyright © 2016年 贺吉辰. All rights reserved.
//

#import "HJCNewViewController.h"
#import "UIBarButtonItem+Extension.h"

@interface HJCNewViewController ()

@end

@implementation HJCNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航栏标题栏内容
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    // 设置导航栏左边按钮的内容
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem buttonItemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
    
    // 设置背景颜色
    self.view.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0  blue:243/255.0  alpha:1.0];
}

#pragma mark - 点击leftBtn的方法
- (void)tagClick {
    NSLog(@"%s被点击了",__FUNCTION__);
}

@end
