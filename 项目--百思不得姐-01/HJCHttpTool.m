//
//  HJCHttpTool.m
//  项目--百思不得姐-01
//
//  Created by 贺吉辰 on 18/3/16.
//  Copyright © 2016年 贺吉辰. All rights reserved.
//

#import "HJCHttpTool.h"
#import <AFNetworking.h>

@implementation HJCHttpTool

/**
 *  发送get请求
 */
+ (void)get:(NSString *)url parameters:(id)parameters success:(void(^)(id json))success failure:(void(^)(NSError* error))failure  {
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    
    
    [manger GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

/**
 *  发送post请求
 */
+ (void)post:(NSString *)url parameters:(id)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [[AFHTTPSessionManager manager] POST:url parameters:parameters constructingBodyWithBlock:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

@end
