//
//  HJCRecommendTagCell.m
//  项目--百思不得姐-01
//
//  Created by 贺吉辰 on 19/3/16.
//  Copyright © 2016年 贺吉辰. All rights reserved.
//

#import "HJCRecommendTagCell.h"
#import "HJCRecommendTag.h"

#import <UIImageView+WebCache.h>

@interface HJCRecommendTagCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageListImageView;
@property (weak, nonatomic) IBOutlet UILabel *themNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *subNumberLabel;

@end

@implementation HJCRecommendTagCell


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

- (void)setRecommendTag:(HJCRecommendTag *)recommendTag {
    _recommendTag = recommendTag;
    
    [self.imageListImageView sd_setImageWithURL:[NSURL URLWithString:recommendTag.image_list] placeholderImage:[UIImage imageNamed: @"defaultUserIcon"]];
    self.themNameLabel.text = recommendTag.theme_name;
    
    NSString *subNumber = nil;
    if (recommendTag.sub_number < 10000) {
        subNumber = [NSString stringWithFormat:@"%zd人订阅",recommendTag.sub_number];
    } else {
        subNumber = [NSString stringWithFormat:@"%0.1lf万人订阅",recommendTag.sub_number / 10000.0];
    }
    
    self.subNumberLabel.text = subNumber;
}

- (void)setFrame:(CGRect)frame {
    frame.origin.x = 10;
    frame.size.width -= 2 * frame.origin.x;
    frame.size.height -= 1;
    [super setFrame:frame];
}

@end
