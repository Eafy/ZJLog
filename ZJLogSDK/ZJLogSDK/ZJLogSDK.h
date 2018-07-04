//
//  ZJLogSDK.h
//  ZJLogSDK
//
//  Created by lzj<lizhijian_21@163.com> on 2018/5/10.
//  Copyright © 2018年 lzj<lizhijian_21@163.com>. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ZJLogSDKDelegate <NSObject>

- (void)didReceiveLogString:(NSString *)logStr;

@end

@interface ZJLogSDK : NSObject

/**
 设置日志代理，否则无法向上输出

 @param delegate 代理对象
 */
+ (void)setDelegate:(id)delegate;

/**
 关闭日志，DEBUG模式下默认开启，输出到控制台
 */
+ (void)setLogOFF;

/**
 日志输出到代理方法
 */
+ (void)setLogOut;

@end
