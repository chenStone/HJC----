//
//  HJCTopicViewController.m
//  项目--百思不得姐-01
//
//  Created by 贺吉辰 on 23/3/16.
//  Copyright © 2016年 贺吉辰. All rights reserved.
//

#import "HJCTopicViewController.h"
#import "HJCTopic.h"
#import "HJCTopicCell.h"
#import "UIView+Extension.h"
#import "HJCConst.h"
#import "HJCCommentViewController.h"

#import <AFNetworking.h>
#import <MJExtension.h>
#import <MJRefresh.h>
#import <SVProgressHUD.h>

@interface HJCTopicViewController ()

// 帖子数据
@property (nonatomic, strong) NSMutableArray *topics;
// 当前的页数
@property (nonatomic, assign) NSInteger page;

@property (nonatomic, copy) NSString *maxtime;
// 请求参数
@property (nonatomic, strong) NSDictionary *parameters;

@property (nonatomic, assign) NSInteger lastSelectedIndex;

@end

@implementation HJCTopicViewController
static NSString *const HJCTopicID = @"topic";

#pragma mark - 懒加载
- (NSMutableArray *)topics {
    if (_topics == nil) {
        _topics = [NSMutableArray array];
    }
    return _topics;
}

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化表格
    [self setupTableView];
    
    // 添加刷新控件
    [self setupRefresh];
}

- (void)setupTableView {
    
    //内边距
    CGFloat bottom = self.tabBarController.tabBar.height;
    CGFloat top = HJCTitilesViewY + HJCTitilesViewH;
    self.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    // 滚动条的内边距
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    // 注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HJCTopicCell class]) bundle:nil] forCellReuseIdentifier:HJCTopicID];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    
    // 监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarSelect) name:HJCTabBarDidSelectNotification object:nil];
    
}

- (void)tabBarSelect {
    if ( self.lastSelectedIndex == self.tabBarController.selectedIndex && self.view.isShowingOnKeyWindow) {
        [self.tableView.mj_header beginRefreshing];
    }
    
    self.lastSelectedIndex = self.tabBarController.selectedIndex;
    
    
    
}

/**
 *  移除销毁通知
 */
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/**
 *  添加刷新控件
 */
- (void)setupRefresh {
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
    
    //自动改变透明度
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
}

/**
 *  加载新数据
 */
- (void)loadNewTopics {
    
    [self.tableView.mj_footer endRefreshing];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @(self.type);
    self.parameters = parameters;
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (self.parameters != parameters) return;
        
        self.page = 0;
        
        // 写入maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        // 字典数据写入模型数据
        self.topics = [HJCTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 刷新表格
        [self.tableView reloadData];
        
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (self.parameters != parameters) return;
        
        [SVProgressHUD showErrorWithStatus:@"请检查网络!"];
        [self.tableView.mj_header endRefreshing];
    }];
}

/**
 *  加载更多数据
 */
- (void)loadMoreTopics {
    
    [self.tableView.mj_header endRefreshing];
    
    self.page++;
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @(self.type);
    parameters[@"maxtime"] = self.maxtime;
    parameters[@"page"] = @(self.page);
    self.parameters = parameters;
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (self.parameters != parameters) return;
        
        NSArray *newTopics = [HJCTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.topics addObjectsFromArray:newTopics];
        
        
        [self.tableView reloadData];
        
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.parameters != parameters) return;
        
        [SVProgressHUD showErrorWithStatus:@"请检查网络!"];
        self.page--;
        [self.tableView.mj_footer endRefreshing];
    }];
    
}

#pragma mark - <UITableViewDataSource>的方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    self.tableView.mj_footer.hidden = (self.topics.count == 0);
    
    return self.topics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HJCTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:HJCTopicID];
    
    cell.topic = self.topics[indexPath.row];
    
    return cell;
}

#pragma mark - <UITableViewDelegate>的方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    HJCTopic *topic = self.topics[indexPath.row];
    
    return topic.topicCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HJCCommentViewController *commentVc = [[HJCCommentViewController alloc] init];
    commentVc.topic = self.topics[indexPath.row];
    [self.navigationController pushViewController:commentVc animated:YES];
    
}

@end
