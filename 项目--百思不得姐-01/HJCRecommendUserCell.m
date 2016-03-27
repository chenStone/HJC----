//
//  HJCRecommendUserCell.m
//  项目--百思不得姐-01
//
//  Created by 贺吉辰 on 19/3/16.
//  Copyright © 2016年 贺吉辰. All rights reserved.
//

#import "HJCRecommendUserCell.h"
#import "HJCRecommendUser.h"
#import <UIImageView+WebCache.h>

@interface HJCRecommendUserCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *fansNumberLabel;

@end

@implementation HJCRecommendUserCell

- (void)awakeFromNib {
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setUser:(HJCRecommendUser *)user {
    _user = user;
    
    self.nameLabel.text = user.screen_name;
    NSString *subNumber = nil;
    if (user.fans_count < 10000) {
        subNumber = [NSString stringWithFormat:@"%zd人关注",user.fans_count];
    } else {
        subNumber = [NSString stringWithFormat:@"%0.1lf万人关注",user.fans_count / 10000.0];
    }
    self.fansNumberLabel.text = subNumber;
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:user.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
}

@end
