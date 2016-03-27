//
//  HJCRecommendTagsViewController.m
//  项目--百思不得姐-01
//
//  Created by 贺吉辰 on 19/3/16.
//  Copyright © 2016年 贺吉辰. All rights reserved.
//

#import "HJCRecommendTagsViewController.h"
#import "HJCRecommendTag.h"
#import "HJCRecommendTagCell.h"

#import <AFNetworking.h>
#import <MJExtension.h>
#import <SVProgressHUD.h>

@interface HJCRecommendTagsViewController ()
/** 装了推荐标签数组 */
@property (nonatomic, strong) NSArray *recommendTags;

@end

@implementation HJCRecommendTagsViewController

static NSString *const HJCTagID = @"recommendTag";

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化表格
    [self setupTableView];
    
    // 加载标签数据
    [self setupLoadTags];
    
}

/**
 *  初始化表格
 */
- (void)setupTableView {
    // 背景颜色
    self.view.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0  blue:243/255.0  alpha:1.0];
    
    // 取消系统的分隔线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 注册表格
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HJCRecommendTagCell class]) bundle:nil] forCellReuseIdentifier:HJCTagID];
    
    self.tableView.rowHeight = 80;
}

/**
 *  加载标签数据
 */
- (void)setupLoadTags {
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    self.title = @"推荐标签";
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"tag_recommend";
    parameters[@"action"] = @"sub";
    parameters[@"c"] = @"topic";
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        
        self.recommendTags = [HJCRecommendTag mj_objectArrayWithKeyValuesArray:responseObject];
        [self.tableView reloadData];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败，请检查网络"];
    }];
}

#pragma mark - <UITableViewDataSource>的方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.recommendTags.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HJCRecommendTagCell *cell = [tableView dequeueReusableCellWithIdentifier:HJCTagID];
    
    cell.recommendTag = self.recommendTags[indexPath.row];
    
    return cell;
}

@end
