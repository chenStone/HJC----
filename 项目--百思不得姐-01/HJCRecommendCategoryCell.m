//
//  HJCRecommendCategoryCell.m
//  项目--百思不得姐-01
//
//  Created by 贺吉辰 on 18/3/16.
//  Copyright © 2016年 贺吉辰. All rights reserved.
//

#import "HJCRecommendCategoryCell.h"
#import "HJCRecommendCategory.h"
#import "UIView+Extension.h"

@interface HJCRecommendCategoryCell ()
/** 选中标记 */
@property (weak, nonatomic) IBOutlet UIView *selectedmark;

@end

@implementation HJCRecommendCategoryCell

- (void)awakeFromNib {
    //设置cell的背景色
    self.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1.0];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    self.selectedmark.hidden = !selected;
    
    self.textLabel.textColor = selected? [UIColor colorWithRed:216/255.0 green:21/255.0 blue:26/255.0 alpha:1.0] : [UIColor colorWithRed:78/255.0 green:78/255.0 blue:78/255.0 alpha:1.0];

    
}

- (void)setCategory:(HJCRecommendCategory *)category {
    _category = category;
    
    self.textLabel.text = category.name;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.textLabel.height = self.height - 2;
}

@end
