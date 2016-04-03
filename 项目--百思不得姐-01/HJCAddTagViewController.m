//
//  HJCAddTagViewController.m
//  项目--百思不得姐-01
//
//  Created by 贺吉辰 on 3/4/16.
//  Copyright © 2016年 贺吉辰. All rights reserved.
//

#import "HJCAddTagViewController.h"
#import "UIView+Extension.h"
#import "HJCConst.h"
#import "HJCTagButton.h"

@interface HJCAddTagViewController ()

/** 内容View */
@property (nonatomic, weak) UIView *contentView;

@property (nonatomic, weak) UITextField *textField;

@property (nonatomic, weak) UIButton *addButton;

@property (nonatomic, strong) NSMutableArray *tagButtons;

@end

@implementation HJCAddTagViewController

#pragma mark - 懒加载
- (NSMutableArray *)tagButtons {
    if (_tagButtons == nil) {
        _tagButtons = [NSMutableArray array];
    }
    return _tagButtons;
}

- (UIButton *)addButton {
    if (_addButton == nil) {
        UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        addButton.backgroundColor = [UIColor colorWithRed:74/255.0 green:139/255.0 blue:209/255.0 alpha:1.0];
        [addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        addButton.width = self.contentView.width;
        addButton.height = 35;
        addButton.x = 0;
        addButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        addButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:addButton];
        self.addButton = addButton;
    }
    return _addButton;
}


#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    
    [self setupContentView];
    
    [self setupTextField];
}

/**
 *  设置导航栏
 */
- (void)setupNav {
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"我的标签";
}

/**
 *  设置内容view
 */
- (void)setupContentView {
    UIView *contentView = [[UIView alloc] init];
    contentView.x = HJCTagMargin;
    contentView.y = HJCTagMargin + 64;
    contentView.width = self.view.width - 2 * contentView.x;
    contentView.height = self.view.height - contentView.y;
    self.contentView = contentView;
    
    [self.view addSubview:contentView];
}

/**
 *  设置textField
 */
- (void)setupTextField {
    UITextField *textField = [[UITextField alloc] init];
    textField.x = 0;
    textField.y = 0;
    textField.width = self.contentView.width;
    textField.height = 25;
    textField.placeholder = @"多个标签用逗号或者换行隔开";
    [textField addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    [self.contentView addSubview:textField];
    self.textField = textField;
}

#pragma mark - 监听文字的改变
/**
 *  监听文字的改变
 */
- (void)textChange {
    if (self.textField.hasText) {
        self.addButton.hidden = NO;
        self.addButton.y = CGRectGetMaxY(self.textField.frame) + HJCTagMargin;
        [self.addButton setTitle:[NSString stringWithFormat:@"添加标签:%@",self.textField.text] forState:UIControlStateNormal];
        
    } else {
        self.addButton.hidden = YES;
    }
    
    [self updateTagButtonFrame];
}

#pragma mark - 标签按钮位置的更新
/**
 *  更新标签按钮的位置
 */
- (void)updateTagButtonFrame {
    for (NSInteger i = 0; i < self.tagButtons.count; i++) {
        HJCTagButton *tagButton = self.tagButtons[i];
        if (i== 0) {
            tagButton.x = 0;
            tagButton.y = 0;
        } else {
            HJCTagButton *lastTagButton = self.tagButtons[i - 1];
            CGFloat letfWidth = CGRectGetMaxX(lastTagButton.frame) + HJCTagMargin;
            CGFloat rightWidth = self.contentView.width - letfWidth;
            
            if (tagButton.width < rightWidth) { //标签按钮小于右边的空间，可以不用换行
                tagButton.x = letfWidth;
                tagButton.y = lastTagButton.y;
            } else {
                tagButton.x = 0;
                tagButton.y = CGRectGetMaxY(lastTagButton.frame) + HJCTagMargin;
            }
        }
    }
    
    HJCTagButton *lastButton = [self.tagButtons lastObject];
    CGFloat leftWidth = CGRectGetMaxX(lastButton.frame) + HJCTagMargin;
    if (self.contentView.width - leftWidth >= [self textFieldWidth]) {
        self.textField.x = leftWidth;
        self.textField.y = lastButton.y;
    } else {
        self.textField.x = 0;
        self.textField.y = CGRectGetMaxY(lastButton.frame) + HJCTagMargin;
    }
}

- (CGFloat)textFieldWidth {
    CGFloat width = [self.textField.text sizeWithAttributes:@{NSFontAttributeName: self.textField.font}].width;
    return MAX(100, width);
}

#pragma mark - 监听按钮的点击方法
/**
 *  监听addButton的点击
 */
- (void)addButtonClick {
    
    HJCTagButton *tagButton = [HJCTagButton buttonWithType:UIButtonTypeCustom];
    [tagButton setTitle:self.textField.text forState:UIControlStateNormal];
    [tagButton addTarget:self action:@selector(tagButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:tagButton];
    [self.tagButtons addObject:tagButton];
    
    [self updateTagButtonFrame];
    
    self.textField.text = nil;
    self.addButton.hidden = YES;
}

/**
 *  监听标签按钮的点击事件
 */
- (void)tagButtonClick:(HJCTagButton *)button {
    [self.tagButtons removeObject:button];
    [button removeFromSuperview];
    [self updateTagButtonFrame];
}

@end
