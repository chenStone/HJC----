//
//  HJCMeCell.m
//  项目--百思不得姐-01
//
//  Created by 贺吉辰 on 2/4/16.
//  Copyright © 2016年 贺吉辰. All rights reserved.
//

#import "HJCMeCell.h"
#import "UIView+Extension.h"

@implementation HJCMeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.textLabel.font = [UIFont systemFontOfSize:15];
        self.textLabel.textColor = [UIColor grayColor];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.imageView.width = 30;
    self.imageView.height = 30;
    self.imageView.centerY = self.contentView.centerY;
    
}

@end
