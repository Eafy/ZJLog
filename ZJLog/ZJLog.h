//
//  ZJLog.h
//  ZJLog
//
//  Created by eafy on 2019/1/2.
//  Copyright © 2019 ZJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZJLogBridgeOC.h"

#ifndef ZLog
#define ZLog(...) [ZJLog log:[NSString stringWithFormat:__VA_ARGS__]]
#endif

typedef enum : NSUInteger {
    ZJLog_LEVEL_VERBOSE = 0,       //任意信息都打印(默认级别)
    ZJLog_LEVEL_DEBUG = 1,         //DEBUG模式下打印
    ZJLog_LEVEL_INFO = 2,          //提示性消息打印
    ZJLog_LEVEL_WARN = 3,          //警告信息打印
    ZJLog_LEVEL_ERROR = 4,         //错误信息打印
} ZJLog_LEVEL;

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

 @param level ZJLog_LEVEL,默认级别ZJLog_LEVEL_VERBOSE
 */
+ (void)setLevel:(ZJLog_LEVEL)level;

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

