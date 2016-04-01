//
//  UIImage+HJCExtension.m
//  项目--百思不得姐-01
//
//  Created by 贺吉辰 on 1/4/16.
//  Copyright © 2016年 贺吉辰. All rights reserved.
//

#import "UIImage+HJCExtension.h"

@implementation UIImage (HJCExtension)

- (UIImage *)circleImage {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(ctx, rect);
    
    CGContextClip(ctx);
    [self drawInRect:rect];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
    
}


@end
