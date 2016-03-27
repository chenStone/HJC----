//
//  HJCEssenceViewController.m
//  项目--百思不得姐-01
//
//  Created by 贺吉辰 on 18/3/16.
//  Copyright © 2016年 贺吉辰. All rights reserved.
//

#import "HJCEssenceViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "HJCRecommendTagsViewController.h"
#import "HJCTopicViewController.h"
#import "UIView+Extension.h"
#import "HJCConst.h"

#import "HJCEssenceButton.h"

@interface HJCEssenceViewController () <UIScrollViewDelegate>
/** 按钮指示器 */
@property (nonatomic, weak) UIView *indicatorView;
/** 当前按钮的状态 */
@property (nonatomic, weak) UIButton *currentBtn;
/** 顶部标题栏 */
@property (nonatomic, weak) UIView *titlesView;
/** 底部内容view */
@property (nonatomic ,weak) UIScrollView *contentView;

@end

@implementation HJCEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航栏内容
    [self setupNav];
    
    // 添加子控制器
    [self setupChildVces];
    
    // 设置顶部的标签栏
    [self setupTitlesView];
    
    // 设置底部的scrollView
    [self setupScrollView];
    
}

/**
 *  设置底部的scrollView
 */
- (void)setupScrollView {
    // 不要自动调整inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 添加scollview到控制器中
    UIScrollView *contentView = [[UIScrollView alloc] init];
    contentView.frame = self.view.bounds;
    contentView.delegate = self;
    contentView.contentSize = CGSizeMake(self.view.width * self.childViewControllers.count, 0);
    contentView.pagingEnabled = YES;
    [self.view insertSubview:contentView belowSubview:self.titlesView];
    self.contentView = contentView;
    
    // 添加第一个子控制器
    [self scrollViewDidEndScrollingAnimation:contentView];
    
}

/**
 *  添加子控制器
 */
- (void)setupChildVces {
    HJCTopicViewController *allVc = [[HJCTopicViewController alloc] init];
    allVc.title = @"全部";
    allVc.type = HJCTopicTypeAll;
    [self addChildViewController:allVc];
    
    HJCTopicViewController *videoVc = [[HJCTopicViewController alloc] init];
    videoVc.title = @"视频";
    videoVc.type = HJCTopicTypeVideo;
    [self addChildViewController:videoVc];
    
    HJCTopicViewController *voiceVc = [[HJCTopicViewController alloc] init];
    voiceVc.title = @"声音";
    voiceVc.type = HJCTopicTypeVoice;
    [self addChildViewController:voiceVc];
    
    HJCTopicViewController *pictureVc = [[HJCTopicViewController alloc] init];
    pictureVc.type = HJCTopicTypePicture;
    pictureVc.title = @"图片";
    [self addChildViewController:pictureVc];
    
    HJCTopicViewController *wordVc = [[HJCTopicViewController alloc] init];
    wordVc.title = @"段子";
    wordVc.type = HJCTopicTypeWord;
    [self addChildViewController:wordVc];
}

/**
 *  设置导航栏内容
 */
- (void)setupNav {
    // 设置导航栏标题栏内容
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    // 设置导航栏左边按钮的内容
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem buttonItemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
    // 设置背景颜色
    self.view.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0  blue:243/255.0  alpha:1.0];
}

/**
 *  设置顶部的标签栏
 */
- (void)setupTitlesView{
    // 添加标题栏
    UIView *titlesView = [[UIView alloc] init];
    titlesView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5];
    titlesView.width = self.view.width;
    titlesView.height = HJCTitilesViewH;
    titlesView.y = 64;
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    
    // 添加红色指示剂
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = [UIColor redColor];
    indicatorView.height = 2;
    indicatorView.y = titlesView.height - indicatorView.height;
    self.indicatorView = indicatorView;
    
    // 添加子按钮
    for (NSInteger i = 0; i < self.childViewControllers.count; i++) {
        HJCEssenceButton *btn = [HJCEssenceButton buttonWithType:UIButtonTypeCustom];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.width = titlesView.width / self.childViewControllers.count;
        btn.height = titlesView.height;
        btn.x = i * btn.width;
        btn.index = i;
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        [btn addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:self.childViewControllers[i].title forState:UIControlStateNormal];
//        // 强制自动布局
//        [self.view layoutIfNeeded];
        [titlesView addSubview:btn];
        
        if (i == 0) {
            btn.enabled = NO;
            self.currentBtn = btn;
            [btn.titleLabel sizeToFit];
            self.indicatorView.width = btn.titleLabel.width;
            self.indicatorView.centerX = btn.centerX;
            
        }
        
        [titlesView addSubview:indicatorView];
    }
}

#pragma mark - 顶部标签栏按钮的点击
- (void)titleClick:(HJCEssenceButton *)btn {
    
    // 修改按钮的状态
    self.currentBtn.enabled = YES;
    btn.enabled = NO;
    self.currentBtn = btn;
    
    //改变动画
    self.indicatorView.width = btn.titleLabel.width;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.centerX = btn.centerX;
    }];
    
    // 滚动
    CGPoint offset = self.contentView.contentOffset;
    
    offset.x = btn.index * self.contentView.width;
    [self.contentView setContentOffset:offset animated:YES];
    
    
}

#pragma mark - 点击leftBtn的方法
- (void)tagClick {
    HJCRecommendTagsViewController *recommendTagsVc = [[HJCRecommendTagsViewController alloc] init];
    
    [self.navigationController pushViewController:recommendTagsVc animated:YES];
}

#pragma mark - <UIScrollViewDelegate>的方法
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    //添加子控制器的view
    // 当前的索引
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    
    // 取出子控制器
    UITableViewController *vc = self.childViewControllers[index];
    vc.view.x = index * scrollView.width;
    vc.view.y = 0;
    vc.view.height = self.view.height;
    
    [self.contentView addSubview:vc.view];
    
    [self titleClick:self.titlesView.subviews[index]];
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

@end
