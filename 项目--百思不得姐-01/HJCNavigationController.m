//
//  HJCNavigationController.m
//  项目--百思不得姐-01
//
//  Created by 贺吉辰 on 18/3/16.
//  Copyright © 2016年 贺吉辰. All rights reserved.
//

#import "HJCNavigationController.h"
#import "UIBarButtonItem+Extension.h"

@implementation HJCNavigationController

+ (void)initialize {
    UINavigationBar *navigationBar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[[HJCNavigationController class]]];
    // 设置导航栏背景图
    [navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    
    // 设置导航栏标题的字体大小
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSFontAttributeName] = [UIFont systemFontOfSize:18];
    [navigationBar setTitleTextAttributes:attr];
    
}

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.childViewControllers.count >0) {
        UIButton *returnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [returnBtn setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [returnBtn setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        [returnBtn setTitle:@"返回" forState:UIControlStateNormal];
        returnBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [returnBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [returnBtn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [returnBtn addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
        [returnBtn sizeToFit];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:returnBtn];
        
        // 隐藏tabBar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated: animated];
}

- (void)pop {
    [self popViewControllerAnimated:YES];
}



@end
