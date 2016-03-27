//
//  HJCRecommendController.m
//  项目--百思不得姐-01
//
//  Created by 贺吉辰 on 18/3/16.
//  Copyright © 2016年 贺吉辰. All rights reserved.
//

#import "HJCRecommendController.h"
#import "HJCRecommendCategory.h"
#import "HJCRecommendCategoryCell.h"
#import "HJCRecommendUserCell.h"
#import "HJCRecommendUser.h"

#import <SVProgressHUD.h>
#import <MJExtension.h>
#import <MJRefresh.h>
#import <AFNetworking.h>

#define HJCSelectedCategory self.categories[self.categoryTableView.indexPathForSelectedRow.row]
@interface HJCRecommendController () <UITableViewDataSource, UITableViewDelegate>
/** 左边类别数据 */
@property (nonatomic, strong) NSArray *categories;
/** 左边类别表格 */
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
/** 右边的数据 */
@property (nonatomic, strong) NSArray *users;
/** 右边用户表格 */
@property (weak, nonatomic) IBOutlet UITableView *userTableView;
/** 保存这次的参数请求 */
@property (nonatomic, strong) NSMutableDictionary *paramters;
/** 保存AFNetworking的请求管理者 */
@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation HJCRecommendController

static NSString *const HJCCategoryID = @"category";
static NSString *const HJCUserID = @"user";

#pragma mark- 懒加载
- (AFHTTPSessionManager *)manager {
    if (_manager == nil) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化表格
    [self setupTableView];
    
    // 添加刷新
    [self setupRefresh];
    
    // 加载category被别的数据
    [self setupCategory];
}

/**
 *  加载category被别的数据
 */
- (void)setupCategory {
    // 显示指示器
    [SVProgressHUD showWithMaskType: SVProgressHUDMaskTypeBlack];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"category";
    parameters[@"c"] = @"subscribe";
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.categories = [HJCRecommendCategory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [self.categoryTableView reloadData];
        // 隐藏指示器
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 显示错误和隐藏
        [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败!"];
    }];
}

/**
 * 初始化表格
 */
- (void)setupTableView {
    // 注册左边表格
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([HJCRecommendCategoryCell class]) bundle:nil] forCellReuseIdentifier:HJCCategoryID];
    // 注册右边表格
    [self.userTableView registerNib:[UINib nibWithNibName:NSStringFromClass([HJCRecommendUserCell class]) bundle:nil] forCellReuseIdentifier:HJCUserID];
    
    // 设置inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.categoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableView.contentInset = self.categoryTableView.contentInset;
    self.userTableView.rowHeight = 80;
    
    // 设置背景颜色
    self.view.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0  blue:243/255.0  alpha:1.0];
}

/**
 * 添加刷新
 */
- (void)setupRefresh {
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
    header.lastUpdatedTimeLabel.hidden = YES;
    self.userTableView.mj_header = header;
    
    
    self.userTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
}

#pragma mark - 下拉加载更多数据
- (void)loadMoreUsers {
    HJCRecommendCategory *category = HJCSelectedCategory;
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"subscribe";
    parameters[@"category_id"] = [NSString stringWithFormat:@"%ld",category.ID];
    parameters[@"page"] = @(++category.currentPage);
    self.paramters = parameters;
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 字典数据 -> 模型数据
        self.users = [HJCRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // user模型加入到类别模型
        [category.users addObjectsFromArray:self.users];
        
        // 将是否需要刷新的状态加入到category模型中
        category.refresh = (category.users.count != category.total);
        
        if (self.paramters != parameters) return ;
        
        [self.userTableView reloadData];
        
        // 结束刷新表格
        [self.userTableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (self.paramters != parameters) return ;
        [self.userTableView.mj_footer endRefreshing];
    }];
}

#pragma mark - 上拉刷新数据
- (void)loadNewUsers {
    HJCRecommendCategory *category = HJCSelectedCategory;
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"subscribe";
    parameters[@"category_id"] = [NSString stringWithFormat:@"%ld",category.ID];
    self.paramters = parameters;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 字典数据 -> 模型数据
        NSArray *users = [HJCRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 清除上次次所有的数据
        [category.users removeAllObjects];
        
        category.total = [responseObject[@"total"] integerValue];
        
        // 设置当前页为第一页
        category.currentPage = 1;
        
        // user模型加入到类别模型
        [category.users addObjectsFromArray:users];
        
        // 将是否需要刷新的状态加入到category模型中
        category.refresh = (category.users.count != category.total);
        
        if (self.paramters != parameters) return ;
        
        [self.userTableView reloadData];
        // 结束刷新
        [self.userTableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.paramters != parameters) return ;
        // 结束刷新
        [self.userTableView.mj_header endRefreshing];
    }];
}

#pragma mark - <UITableViewDataSource>的方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.categoryTableView) {
        return self.categories.count;
    }
    else {
        // 新版中的就是这个样子的
        HJCRecommendCategory *category = HJCSelectedCategory;
        return category.users.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.categoryTableView) {
        HJCRecommendCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:HJCCategoryID];
        cell.category = self.categories[indexPath.row];
        
        return cell;
    } else {
        HJCRecommendUserCell *cell = [tableView dequeueReusableCellWithIdentifier:HJCUserID];
        HJCRecommendCategory *category = HJCSelectedCategory;
        cell.user = category.users[indexPath.row];
        // 是否隐藏刷新状态
        self.userTableView.mj_footer.hidden = !category.isRefresh;
        return cell;
    }
}

#pragma mark - <UITableViewDelegate>的方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.categoryTableView) {
        // 结束刷新
        [self.userTableView.mj_header endRefreshing];
        [self.userTableView.mj_footer endRefreshing];
        
        HJCRecommendCategory *category = self.categories[indexPath.row];
        if (category.users.count) { //类别模型中有了这个类别
            self.users = category.users;
            [self.userTableView reloadData];
        } else { //类别模型中没有加载过这个类别
            // 马上刷新表格，不要让上一个表格残留在表格上
            [self.userTableView reloadData];
            
            [self.userTableView.mj_header beginRefreshing];
        }
    }
}

#pragma mark - 销毁后处理
-(void)dealloc {
    // 停止所有的操作
    [self.manager.operationQueue cancelAllOperations];
}

@end
