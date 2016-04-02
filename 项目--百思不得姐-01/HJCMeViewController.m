//
//  HJCMeViewController.m
//  项目--百思不得姐-01
//
//  Created by 贺吉辰 on 18/3/16.
//  Copyright © 2016年 贺吉辰. All rights reserved.
//

#import "HJCMeViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "HJCConst.h"
#import "HJCMeCell.h"
#import "UIImage+HJCExtension.h"
#import "HJCMeFooterView.h"


static NSString *HJCMeID = @"me";
@interface HJCMeViewController ()

@end

@implementation HJCMeViewController

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    
    [self setupTableView];
}

- (void)setupNav {
    // 设置导航栏标题栏内容
    self.navigationItem.title = @"我的";
    
    // 设置导航栏右边按钮的内容
    self.navigationItem.rightBarButtonItems = @[[UIBarButtonItem buttonItemWithImage:@"mine-setting-icon" highImage:@"mine-setting-icon-click" target:self action:@selector(settingClick)],[UIBarButtonItem buttonItemWithImage:@"mine-moon-icon" highImage:@"mine-moon-icon-click" target:self action:@selector(moonClick)]];
}

- (void)setupTableView {
    // 设置背景颜色
    self.view.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0  blue:243/255.0  alpha:1.0];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 注册
    [self.tableView registerClass:[HJCMeCell class] forCellReuseIdentifier:HJCMeID];
    
    // 调整cell之间的距离
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight =  HJCTopicCellMargin;
    
    // 调整内边距
    self.tableView.contentInset = UIEdgeInsetsMake(HJCTopicCellMargin - 35, 0, 0, 0);
    
    // 添加footerView
    self.tableView.tableFooterView = [[HJCMeFooterView alloc] init];
}

#pragma mark - <UITableViewDataSource>方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HJCMeCell *cell = [tableView dequeueReusableCellWithIdentifier:HJCMeID];
    
    if (indexPath.section == 0) {
        cell.imageView.image = [[UIImage imageNamed:@"defaultUserIcon"] circleImage];
        cell.textLabel.text = @"登录/注册";
    } else if (indexPath.section == 1) {
        cell.textLabel.text = @"离线下载";
    }
    return cell;
}

#pragma mark - 点击leftBtn的方法
- (void)moonClick {
    NSLog(@"%s被点击了",__func__);
}

- (void)settingClick {
    NSLog(@"%s被点击了",__func__);
}

@end
