//
//  HJCPostWordViewController.m
//  项目--百思不得姐-01
//
//  Created by 贺吉辰 on 2/4/16.
//  Copyright © 2016年 贺吉辰. All rights reserved.
//

#import "HJCPostWordViewController.h"
#import "HJCPlaceholderTextView.h"
#import "HJCAddTagToolBar.h"
#import "UIView+Extension.h"

@interface HJCPostWordViewController () <UITextViewDelegate>

@property (nonatomic, weak) HJCAddTagToolBar *toolbar;

@end

@implementation HJCPostWordViewController 

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航栏
    [self setupNav];
    
    // 设置textView
    [self setupTextView];
    
    [self setupToolbar];
    
}

- (void)setupToolbar {
    HJCAddTagToolBar *toolbar = [HJCAddTagToolBar toolbar];
    toolbar.width = self.view.width;
    toolbar.y = self.view.height - toolbar.height;
    [self.view addSubview:toolbar];
    self.toolbar = toolbar;
    
    // 添加通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

-  (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)keyboardWillChangeFrame:(NSNotification *)notification {
    // 键盘最终的frame
    CGRect keyboardF = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // 动画时间
    CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        self.toolbar.transform = CGAffineTransformMakeTranslation(0,  keyboardF.origin.y - self.view.height);
    }];
}

/**
 *  设置textView
 */
- (void)setupTextView {
    HJCPlaceholderTextView *textView = [[HJCPlaceholderTextView alloc] init];
    textView.frame = self.view.bounds;
    textView.placeholder = @"这里添加文字，请勿发送色情、政治等违反国家法律的内容，违者封号处理。";
    textView.delegate = self;
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


#pragma mark - <UITextViewDelegate>方法
- (void)textViewDidChange:(UITextView *)textView {
    self.navigationItem.rightBarButtonItem.enabled = textView.hasText;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}


@end
