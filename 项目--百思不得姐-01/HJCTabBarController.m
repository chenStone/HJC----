//
//  HJCTabBarController.m
//  项目--百思不得姐-01
//
//  Created by 贺吉辰 on 17/3/16.
//  Copyright © 2016年 贺吉辰. All rights reserved.
//

#import "HJCTabBarController.h"
#import "HJCNavigationController.h"
#import "HJCEssenceViewController.h"
#import "HJCNewViewController.h"
#import "HJCFriendTrendsViewController.h"
#import "HJCMeViewController.h"

#import "HJCTabBar.h"

@interface HJCTabBarController ()

@end

@implementation HJCTabBarController

+ (void)initialize {
    //设置tabBar栏的字体颜色
    UITabBarItem *item = [UITabBarItem appearanceWhenContainedInInstancesOfClasses:@[[UITabBarController class]]];
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSForegroundColorAttributeName] = [UIColor grayColor];
    [item setTitleTextAttributes:attr forState:UIControlStateNormal];
    NSMutableDictionary *selecAttr = [NSMutableDictionary dictionary];
    selecAttr[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    [item setTitleTextAttributes:selecAttr forState:UIControlStateSelected];
}

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    HJCEssenceViewController *essenceVc = [[HJCEssenceViewController alloc] init];
    [self addChildVc:essenceVc title:@"精华" image:@"tabBar_essence_icon" seleImage:@"tabBar_essence_click_icon"];
    
    HJCNewViewController *newVc = [[HJCNewViewController alloc] init];
    [self addChildVc:newVc title:@"新帖" image:@"tabBar_new_icon" seleImage:@"tabBar_new_click_icon"];
    
    HJCFriendTrendsViewController *friendTrendsVc = [[HJCFriendTrendsViewController alloc] init];
    [self addChildVc:friendTrendsVc title:@"关注" image:@"tabBar_friendTrends_icon" seleImage:@"tabBar_friendTrends_click_icon"];
    
    HJCMeViewController *meVc = [[HJCMeViewController alloc] initWithStyle:UITableViewStyleGrouped];
    [self addChildVc:meVc title:@"我" image:@"tabBar_me_icon" seleImage:@"tabBar_me_click_icon"];
    
    // 添加自定义tabBar
    [self setValue:[[HJCTabBar alloc] init] forKeyPath:@"tabBar"];
    
}

/**
 *  添加子控制器
 *
 *  @param childVc   子控制器
 *  @param title     子控制器的标题
 *  @param image     子控制器的图片
 *  @param seleImage 子控制器选中后的图片
 */
- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image seleImage:(NSString *)seleImage {
    childVc.tabBarItem.title = title;
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    childVc.tabBarItem.selectedImage = [UIImage imageNamed:seleImage];
    HJCNavigationController *nav = [[HJCNavigationController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
}

@end
