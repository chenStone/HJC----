//
//  HJCTagButton.m
//  项目--百思不得姐-01
//
//  Created by 贺吉辰 on 3/4/16.
//  Copyright © 2016年 贺吉辰. All rights reserved.
//

#import "HJCTagButton.h"
#import "UIView+Extension.h"
#import "HJCConst.h"

@implementation HJCTagButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor colorWithRed:74/255.0 green:139/255.0 blue:209/255.0 alpha:1.0];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"chose_tag_close_icon"] forState:UIControlStateNormal];
        
    }
    return self;
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state {
    [super setTitle:title forState:state];
    [self sizeToFit];
    self.width += 3 * HJCTagMargin;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.titleLabel.x = HJCTagMargin;
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + HJCTagMargin;
}

@end
