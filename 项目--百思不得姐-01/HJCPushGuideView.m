//
//  HJCPushGuideView.m
//  项目--百思不得姐-01
//
//  Created by 贺吉辰 on 21/3/16.
//  Copyright © 2016年 贺吉辰. All rights reserved.
//

#import "HJCPushGuideView.h"

@implementation HJCPushGuideView

+ (void)show {
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    // 获取当前的版本号
    NSString *key = @"CFBundleShortVersionString";
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    // 获取沙盒中的版本号
    NSString *sanboxVersion = [[NSUserDefaults standardUserDefaults] stringForKey:key];
    
    if (![currentVersion isEqualToString:sanboxVersion]) {
        HJCPushGuideView *guideView = [HJCPushGuideView guideView];
        guideView.frame = window.bounds;
        [window addSubview:guideView];
        
        // 将版本号写入沙盒
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

+ (instancetype)guideView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (IBAction)close {
    [self removeFromSuperview];
}



@end
