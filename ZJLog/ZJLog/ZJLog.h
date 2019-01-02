//
//  ZJLog.h
//  ZJLog
//
//  Created by lzj<lizhijian_21@163.com> on 2019/1/2.
//  Copyright © 2019 ZJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ZJLogDelegate <NSObject>

- (void)didReceiveLogString:(NSString *)logStr;

@end

@interface ZJLog : NSObject

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

