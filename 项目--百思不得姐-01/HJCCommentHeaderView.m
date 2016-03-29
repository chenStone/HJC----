//
//  HJCCommentHeaderView.m
//  项目--百思不得姐-01
//
//  Created by 贺吉辰 on 29/3/16.
//  Copyright © 2016年 贺吉辰. All rights reserved.
//

#import "HJCCommentHeaderView.h"
#import "UIView+Extension.h"

@interface HJCCommentHeaderView ()
@property (nonatomic, weak) UILabel *label;

@end

@implementation HJCCommentHeaderView

+ (instancetype)headerViewWithTableView:(UITableView *)tableView {
    static NSString *ID = @"header";
    HJCCommentHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (header == nil) {
        header = [[HJCCommentHeaderView alloc] initWithReuseIdentifier:ID];
    }
    
    
    return header;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = [UIColor colorWithRed:67/255.0 green:67/255.0 blue:67/255.0 alpha:1.0];
        label.font = [UIFont systemFontOfSize:13];
        label.width = 200;
        label.x = 5;
        label.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [self.contentView addSubview:label];
        self.label = label;
    }
    return self;
}

- (void)setTitle:(NSString *)title {
    _title = [title copy];
    
    self.label.text = title;

}
@end
