//
//  HJCCommentViewController.m
//  项目--百思不得姐-01
//
//  Created by 贺吉辰 on 28/3/16.
//  Copyright © 2016年 贺吉辰. All rights reserved.
//

#import "HJCCommentViewController.h"
#import "HJCTopicCell.h"
#import "HJCTopic.h"
#import "UIView+Extension.h"
#import "HJCConst.h"
#import "HJCComment.h"
#import "HJCCommentHeaderView.h"
#import "HJCCommentCell.h"

#import <MJRefresh.h>
#import <MJExtension.h>
#import <AFNetworking.h>

NSString *const HJCCommentID = @"comment";

@interface HJCCommentViewController () <UITableViewDelegate, UITableViewDataSource>
/** 底部工具栏的底部约束 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSpace;
/** tableivew */
@property (weak, nonatomic) IBOutlet UITableView *tableView;
/** 热门评论 */
@property (nonatomic, strong) NSArray *hotComments;
/** 最新评论 */
@property (nonatomic, strong) NSMutableArray *lastComments;
/** 保存topic的tmd_cmd */
@property (nonatomic, strong) HJCComment *saved_top_cmt;
/** 保存当前页 */
@property (nonatomic, assign) NSInteger page;
/** AFHTTPSessionManager */
@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation HJCCommentViewController

- (AFHTTPSessionManager *)manager {
    if (_manager == nil) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 基本设置
    [self setupBasic];
    
    // 添加tableViewHead
    [self setupHeader];
    
    // 添加刷新数据
    [self setupRefresh];
    
    [self loadNewComments];
    
}

/**
 *  添加刷新数据
 */
- (void)setupRefresh {
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComments)];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComments)];
    
}

/**
 *  读取更多评论数据
 */
- (void)loadMoreComments {
    
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    [self.tableView.mj_footer beginRefreshing];
    
    NSInteger page = self.page++;
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"dataList";
    parameters[@"c"] = @"comment";
    parameters[@"data_id"] = self.topic.ID;
    HJCComment *lastComent = [self.lastComments lastObject];
    parameters[@"lastcid"] = lastComent.ID;
    parameters[@"page"] = @(page);
    
    [self.manager POST:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            self.tableView.mj_footer.hidden = YES;
            return;
        }
        
        self.page = page;
        
        NSArray *newArray = [HJCComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        [self.lastComments addObjectsFromArray:newArray];
        
        [self.tableView reloadData];
        
        // 控制footer的状态
        NSInteger total = [responseObject[@"total"] integerValue];
        if (self.lastComments.count >= total) { // 全部加载完毕
            self.tableView.mj_footer.hidden = YES;
        } else {
            // 结束刷新状态
            [self.tableView.mj_footer endRefreshing];
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_footer endRefreshing];
    }];
}

/** 
 *  读取新的评论
 */
- (void)loadNewComments {
    
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"dataList";
    parameters[@"c"] = @"comment";
    parameters[@"data_id"] = self.topic.ID;
    parameters[@"hot"] = @(1);
    
    [self.manager POST:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            self.tableView.mj_footer.hidden = YES;
            return;
        }
        
        [self.tableView.mj_header endRefreshing];
        
        self.page = 1;
        
        self.hotComments = [HJCComment mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        self.lastComments = [HJCComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        [self.tableView reloadData];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];
    }];
}

- (void)setupHeader {
    UIView *header = [[UIView alloc] init];
    HJCTopicCell *cell = [HJCTopicCell cell];
    if (self.topic.top_cmt) {
        self.saved_top_cmt = self.topic.top_cmt;
       self.topic.top_cmt = nil;
        [self.topic setValue:@0 forKey:@"topicCellHeight"];
    }
    cell.topic = self.topic;
    cell.moreBtn.hidden = YES;
    cell.frame = CGRectMake(0, HJCTopicCellMargin, [UIScreen mainScreen].bounds.size.width, self.topic.topicCellHeight);
    
    header.height = self.topic.topicCellHeight + HJCTopicCellMargin;
    [header addSubview:cell];
    self.tableView.tableHeaderView = header;
}


/**
 *  基本设置
 */
- (void)setupBasic {
    // 背景颜色
    self.tableView.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0  blue:243/255.0  alpha:1.0];
    
    self.title = @"评论";
    
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setImage:[UIImage imageNamed:@"comment_nav_item_share_icon"] forState:UIControlStateNormal];
    [rightBtn setImage:[UIImage imageNamed:@"comment_nav_item_share_icon_click"] forState:UIControlStateHighlighted];
    [rightBtn sizeToFit];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    // 监听键盘
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    // 注册表格
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HJCCommentCell class]) bundle:nil] forCellReuseIdentifier:HJCCommentID];
    
    self.tableView.estimatedRowHeight = 44;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, HJCTopicCellBottomBarH, 0);

}

- (void)keyboardWillChangeFrame:(NSNotification *)notification {
    NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect frame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.bottomSpace.constant = [UIScreen mainScreen].bounds.size.height - frame.origin.y;
    
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    if (self.saved_top_cmt) {
        self.topic.top_cmt = self.saved_top_cmt;
        [self.topic setValue:@0 forKeyPath:@"topicCellHeight"];
    }
    
    [self.manager invalidateSessionCancelingTasks:YES];
}

#pragma mark - <UITableViewDataSource>方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    NSInteger hotCount = self.hotComments.count;
    NSInteger lastCount = self.lastComments.count;
    if (hotCount) return 2; // 有热门评论就返回2组
    if (lastCount) return 1;  // 没有热门评论，有最新评论就返回1
    return 0; // 都没有
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    HJCCommentHeaderView *header = [HJCCommentHeaderView headerViewWithTableView:tableView];
    if (section == 0) {
        header.title = self.hotComments.count? @"热门评论":@"最新评论";
    } else {
        header.title = @"最新评论";
    }
    return header;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger hotCount = self.hotComments.count;
    NSInteger lastCount = self.lastComments.count;
    
    if (section == 0) {
        return hotCount? hotCount : lastCount;
    }
    return lastCount;
}

- (NSArray *)commentsInSection:(NSInteger)section {
    NSInteger hotCount = self.hotComments.count;
    if (section == 0) {
        return hotCount? self.hotComments : self.lastComments;
    }
    return self.lastComments;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"comment";
    HJCCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    HJCComment *comment = [self commentsInSection:indexPath.section][indexPath.row];
    cell.comment = comment;
    
    return cell;
}

#pragma mark - <UITableViewDelegate>方法
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HJCCommentCell *cell = (HJCCommentCell *)[tableView cellForRowAtIndexPath:indexPath];
    UIMenuController *menu = [UIMenuController sharedMenuController];
    if ([menu isMenuVisible]) {
        [menu setMenuVisible:NO animated:YES];
        return;
    }
    // 成为第一响应者
    [cell becomeFirstResponder];
    [menu setTargetRect:CGRectMake(0, cell.height * 0.5, cell.width, cell.height * 0.5) inView:cell];
    UIMenuItem *ding = [[UIMenuItem alloc] initWithTitle:@"顶" action:@selector(ding:)];
    UIMenuItem *replay = [[UIMenuItem alloc] initWithTitle:@"回复" action:@selector(replay:)];
    UIMenuItem *report = [[UIMenuItem alloc] initWithTitle:@"举报" action:@selector(report:)];
    menu.menuItems = @[ding, replay, report];
    [menu setMenuVisible:YES animated:YES];
    
}

- (void)ding:(UIMenuController *)menu {
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    NSLog(@"%s-----%@",__func__,[self commentsInSection:indexPath.section][indexPath.row]);
}

- (void)replay:(UIMenuController *)menu {
    
}

- (void)report:(UIMenuController *)menu {
    
}

@end
