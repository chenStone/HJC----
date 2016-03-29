//
//  HJCCommentHeaderView.h
//  项目--百思不得姐-01
//
//  Created by 贺吉辰 on 29/3/16.
//  Copyright © 2016年 贺吉辰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HJCCommentHeaderView : UITableViewHeaderFooterView

@property (nonatomic, copy) NSString *title;

+ (instancetype)headerViewWithTableView:(UITableView *)tableView;

@end
