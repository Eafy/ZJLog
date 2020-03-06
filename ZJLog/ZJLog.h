//
//  ZJLog.h
//  ZJLog
//
//  Created by lzj<lizhijian_21@163.com> on 2019/1/2.
//  Copyright © 2019 ZJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZJLogBridgeOC.h"

#define CLog(...) [ZJLog log:[NSString stringWithFormat:__VA_ARGS__]]

typedef enum : NSUInteger {
    ZJLOG_LEVEL_VERBOSE = 0,       //任意信息都打印(默认级别)
    ZJLOG_LEVEL_DEBUG = 1,         //DEBUG模式下打印
    ZJLOG_LEVEL_INFO = 2,          //提示性消息打印
    ZJLOG_LEVEL_WARN = 3,          //警告信息打印
    ZJLOG_LEVEL_ERROR = 4,         //错误信息打印
} ZJLOG_LEVEL;

@protocol ZJLogDelegate <NSObject>

- (void)didReceiveLogString:(NSString *_Nullable)logStr;

@end

@interface ZJLog : NSObject

/**
 日志开关，DEBUG模式下默认开启
 */
+ (void)setLogOFF;

/**
 设置日志显示级别

 @param level ZJLOG_LEVEL,默认级别ZJLOG_LEVEL_VERBOSE
 */
+ (void)setLevel:(ZJLOG_LEVEL)level;

/**
 设置日志代理，否则无法向上输出

 @param delegate 代理对象
 */
+ (void)setDelegate:(id _Nullable)delegate;

/**
 是否将日志保存到沙盒并上传至服务器
 #上传功能暂未实现

 @param isSave YES:保存，默认NO
 */
+ (void)saveLog:(BOOL)isSave;


+ (void)log:(NSString *_Nullable)log;

@end

