//
//  HJCHttpTool.h
//  项目--百思不得姐-01
//
//  Created by 贺吉辰 on 18/3/16.
//  Copyright © 2016年 贺吉辰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HJCHttpTool : NSObject

/** 发送get请求 */
+ (void)get:(NSString *)url parameters:(id)parameters success:(void(^)(id json))success failure:(void(^)(NSError* error))failure;

/** 发送post请求 */
+(void)post:(NSString *)url parameters:(id)parameters success:(void(^)(id json))success failure:(void(^)(NSError* error))failure;



@end
