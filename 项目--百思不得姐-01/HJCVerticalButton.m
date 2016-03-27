//
//  HJCVerticalButton.m
//  项目--百思不得姐-01
//
//  Created by 贺吉辰 on 20/3/16.
//  Copyright © 2016年 贺吉辰. All rights reserved.
//

#import "HJCVerticalButton.h"
#import "UIView+Extension.h"

@implementation HJCVerticalButton

- (void)awakeFromNib {
    [self setup];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 设置按钮的图片位置
    self.imageView.x = 0;
    self.imageView.y = 0;
//    self.imageView.width = self.width;
//    self.imageView.height = self.width;
    
    // 设置按钮的文字位置
    self.titleLabel.x = 0;
    self.titleLabel.y = self.width;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.width;
}

@end
