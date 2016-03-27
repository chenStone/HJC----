//
//  HJCProgressView.m
//  项目--百思不得姐-01
//
//  Created by 贺吉辰 on 25/3/16.
//  Copyright © 2016年 贺吉辰. All rights reserved.
//

#import "HJCProgressView.h"

@implementation HJCProgressView

- (void)awakeFromNib {
    self.roundedCorners = 2;
    self.progressLabel.textColor = [UIColor whiteColor];
}

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated{
    
    NSString *textContent = [NSString stringWithFormat:@"%.0f%%",progress * 100];
    
    textContent = [textContent stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    self.progressLabel.text = textContent;
    
    [super setProgress:progress animated:NO];
}



@end
