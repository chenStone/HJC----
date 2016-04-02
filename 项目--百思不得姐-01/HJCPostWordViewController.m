//
//  HJCPostWordViewController.m
//  项目--百思不得姐-01
//
//  Created by 贺吉辰 on 2/4/16.
//  Copyright © 2016年 贺吉辰. All rights reserved.
//

#import "HJCPostWordViewController.h"
#import "HJCPlaceholderTextView.h"

@implementation HJCPostWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航栏
    [self setupNav];
    
    // 设置textView
    [self setupTextView];
}

/**
 *  设置textView
 */
- (void)setupTextView {
    HJCPlaceholderTextView *textView = [[HJCPlaceholderTextView alloc] init];
    textView.frame = self.view.bounds;
    textView.placeholder = @"这里添加文字，请勿发送色情、政治等违反国家法律的内容，违者封号处理。";
    [textView becomeFirstResponder];
    [self.view addSubview:textView];
}
/**
 *  设置导航栏
 */
- (void)setupNav {
    // 背景颜色
    self.view.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0  blue:243/255.0  alpha:1.0];
    
    //导航栏内容
    self.title = @"发表文字";
    
    // 导航栏左边按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    
    // 导航栏右边按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStyleDone target:self action:@selector(post)];
    self.navigationItem.rightBarButtonItem.enabled = NO; // 不能点击
    // 强制刷新
    [self.navigationController.navigationBar layoutIfNeeded];
}

- (void)cancel {
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)post {
    NSLog(@"发布了");
}

@end
