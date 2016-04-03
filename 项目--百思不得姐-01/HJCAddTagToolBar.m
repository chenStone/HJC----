//
//  HJCAddTagToolBar.m
//  项目--百思不得姐-01
//
//  Created by 贺吉辰 on 3/4/16.
//  Copyright © 2016年 贺吉辰. All rights reserved.
//

#import "HJCAddTagToolBar.h"
#import "UIView+Extension.h"
#import "HJCAddTagViewController.h"
#import "HJCConst.h"

@interface HJCAddTagToolBar ()

@property (weak, nonatomic) IBOutlet UIView *topView;


@end

@implementation HJCAddTagToolBar

+(instancetype)toolbar {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

- (void)awakeFromNib {
    // 添加按钮到顶部view
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addButton setImage:[UIImage imageNamed:@"tag_add_icon"] forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
    addButton.size = addButton.currentImage.size;
    addButton.x = HJCTopicCellMargin;
    addButton.y = HJCTopicCellMargin;
    [self.topView addSubview:addButton];
}

- (void)addButtonClick {
    HJCAddTagViewController *addTagVc = [[HJCAddTagViewController alloc] init];
    UINavigationController *nav = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController.presentedViewController;
    [nav pushViewController:addTagVc animated:YES];
}
@end
