//
//  HJCFriendTrendsViewController.m
//  项目--百思不得姐-01
//
//  Created by 贺吉辰 on 18/3/16.
//  Copyright © 2016年 贺吉辰. All rights reserved.
//

#import "HJCFriendTrendsViewController.h"
#import "HJCRecommendController.h"
#import "UIBarButtonItem+Extension.h"
#import "HJCLoginRegisterViewController.h"

@interface HJCFriendTrendsViewController ()

@end

@implementation HJCFriendTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航栏标题栏内容
    self.navigationItem.title = @"我的关注";
    
    // 设置导航栏左边按钮的内容
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem buttonItemWithImage:@"friendsRecommentIcon" highImage:@"friendsRecommentIcon-click" target:self action:@selector(friendsClick)];
    
    // 设置背景颜色
    self.view.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0  blue:243/255.0  alpha:1.0];
}

#pragma mark - 点击leftBtn的方法
- (void)friendsClick {
    HJCRecommendController *recommendVc = [[HJCRecommendController alloc] init];
    recommendVc.title = @"推荐关注";
    [self.navigationController pushViewController:recommendVc animated:YES];
}

#pragma mark - 登录注册按钮
- (IBAction)loginRegister {
    HJCLoginRegisterViewController *loginRegisterVc = [[HJCLoginRegisterViewController alloc] init];
    [self presentViewController:loginRegisterVc animated:YES completion:nil];
    
}

@end
