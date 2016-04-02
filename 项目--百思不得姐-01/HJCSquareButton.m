//
//  HJCSquareButton.m
//  项目--百思不得姐-01
//
//  Created by 贺吉辰 on 2/4/16.
//  Copyright © 2016年 贺吉辰. All rights reserved.
//

#import "HJCSquareButton.h"
#import "UIView+Extension.h"
#import "HJCSquare.h"

#import <UIButton+WebCache.h>

@implementation HJCSquareButton


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont systemFontOfSize:12];
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage imageNamed:@"mainCellBackground"] forState:UIControlStateNormal];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 设置按钮的图片位置
    self.imageView.y = self.height * 0.2;
    self.imageView.width = self.width * 0.5;
    self.imageView.height = self.imageView.width;
    self.imageView.centerX = self.width * 0.5;
    
    // 设置按钮的文字位置
    self.titleLabel.x = 0;
    self.titleLabel.y = CGRectGetMaxY(self.imageView.frame);
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y;
}

- (void)setSquare:(HJCSquare *)square {
    _square = square;
    
    [self setTitle:square.name forState:UIControlStateNormal];
    [self sd_setImageWithURL:[NSURL URLWithString:square.icon] forState:UIControlStateNormal];
    
}

@end
