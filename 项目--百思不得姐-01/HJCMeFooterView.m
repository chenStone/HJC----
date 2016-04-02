//
//  HJCMeFooterView.m
//  项目--百思不得姐-01
//
//  Created by 贺吉辰 on 2/4/16.
//  Copyright © 2016年 贺吉辰. All rights reserved.
//

#import "HJCMeFooterView.h"
#import "HJCSquare.h"
#import "UIView+Extension.h"
#import "HJCSquareButton.h"

#import <MJExtension.h>
#import <AFNetworking.h>

@interface HJCMeFooterView ()

@property (nonatomic, strong) NSArray *squares;
@property (nonatomic, assign) CGFloat footerH;
@end

@implementation HJCMeFooterView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
        parameters[@"a"] = @"square";
        parameters[@"c"] = @"topic";
        [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            self.squares = [HJCSquare mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
            // 创建方块
            [self creatSquare];

        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
    }
    return self;
}

- (void)creatSquare {
    NSInteger cols = 4;
    CGFloat btnW = self.width / cols;
    CGFloat btnH = btnW;
    for (NSInteger i = 0; i < self.squares.count; i++) {
        HJCSquareButton *btn = [HJCSquareButton buttonWithType:UIButtonTypeCustom];
        btn.square = self.squares[i];
        [self addSubview:btn];
        NSInteger col = i / cols;
        NSInteger row = i % cols;
        CGFloat btnX = col * btnW;
        CGFloat btnY = row * btnH;

        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    }
    // 总行数
    NSInteger rows = (self.squares.count + cols - 1)/cols;
    self.height = rows * btnH;
    
    [self setNeedsDisplay];
}

@end
