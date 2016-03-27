//
//  HJCTextField.m
//  项目--百思不得姐-01
//
//  Created by 贺吉辰 on 21/3/16.
//  Copyright © 2016年 贺吉辰. All rights reserved.
//

#import "HJCTextField.h"
#import <objc/runtime.h>

@implementation HJCTextField

- (void)awakeFromNib {
    //使用运行时去获得_placeholderLabel，通过这个值利用kvc可以修改占位文字的颜色，
//    unsigned int count = 0;
//    Ivar *ivars = class_copyIvarList([UITextField class], &count);
//    for (int i = 0; i < count; i++) {
//        Ivar ivar = *(ivars + i);
//        NSLog(@"%s",ivar_getName(ivar));
//    }
//    
//    free(ivars);
    
    // 文字属性
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSForegroundColorAttributeName] = [UIColor grayColor];
    NSAttributedString * phonePlaceholder = [[NSAttributedString alloc] initWithString:@" 手机号" attributes:attr];
    self.attributedPlaceholder = phonePlaceholder;
    
    // 设置光标颜色
    self.tintColor = self.textColor;
}

- (BOOL)becomeFirstResponder {
    // 文字属性
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSForegroundColorAttributeName] = self.textColor;
    NSAttributedString * phonePlaceholder = [[NSAttributedString alloc] initWithString:@" 手机号" attributes:attr];
    self.attributedPlaceholder = phonePlaceholder;
    
    return [super becomeFirstResponder];
}

- (BOOL)resignFirstResponder {
    // 文字属性
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSForegroundColorAttributeName] = [UIColor grayColor];
    NSAttributedString * phonePlaceholder = [[NSAttributedString alloc] initWithString:@" 手机号" attributes:attr];
    self.attributedPlaceholder = phonePlaceholder;
    
    return [super resignFirstResponder];
}

@end
