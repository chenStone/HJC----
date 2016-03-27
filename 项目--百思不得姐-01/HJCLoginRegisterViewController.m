//
//  HJCLoginRegisterViewController.m
//  项目--百思不得姐-01
//
//  Created by 贺吉辰 on 20/3/16.
//  Copyright © 2016年 贺吉辰. All rights reserved.
//

#import "HJCLoginRegisterViewController.h"
#import "UIView+Extension.h"

@interface HJCLoginRegisterViewController ()
/** login最外面的view的约束 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginLeftMargin;
/** 登录按钮 */
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
/** 手机号输入框 */
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
/** 密码输入框 */
@property (weak, nonatomic) IBOutlet UITextField *pwdField;

@end

@implementation HJCLoginRegisterViewController

#pragma mark - 改变状态栏样式
-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//  在xib中利用KVC设置
//  self.loginBtn.layer.cornerRadius = 5;
//  self.loginBtn.layer.masksToBounds = YES;
    
    // 手机号placeholder设置
    // 文字属性
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSForegroundColorAttributeName] = [UIColor grayColor];
    NSAttributedString * phonePlaceholder = [[NSAttributedString alloc] initWithString:@"手机号" attributes:attr];
    self.phoneField.attributedPlaceholder = phonePlaceholder;
    
    // 密码placeholder设置
    NSAttributedString * pwdPlaceholder = [[NSAttributedString alloc] initWithString:@"密码" attributes:attr];
    self.pwdField.attributedPlaceholder = pwdPlaceholder;
    
}

#pragma mark - 关闭控制器
- (IBAction)close {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 注册按钮点击
- (IBAction)registerClick:(UIButton *)registerBtn {
    // 退出键盘
    [self.view endEditing:YES];
    
    if (self.loginLeftMargin.constant == 0) { //登录界面
        self.loginLeftMargin.constant = -self.view.width;
        registerBtn.selected = YES;
    } else { // 注册界面
        self.loginLeftMargin.constant = 0;
        registerBtn.selected = NO;
        
        
    }
    
    
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
    
}
@end
