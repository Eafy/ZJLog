//
//  ZJLog.m
//  ZJLog
//
//  Created by lzj<lizhijian_21@163.com> on 2019/1/2.
//  Copyright © 2019 ZJ. All rights reserved.
//

#import "ZJLog.h"
#import "ZJLogEx.h"
#import "ZJLogWriteManager.h"

void CPrintfSendCallback(char *log)
{
    [[ZJLog sharedTool] sendLogStr:[NSString stringWithFormat:@"%s", log]];
}

@interface ZJLog ()

@property (nonatomic,assign) BOOL logEnable;        //日志开关
@property (nonatomic,assign) BOOL LogOutEnable;     //日志向上输出开关
@property (nonatomic,assign) BOOL saveEnable;       //日志保存开关

@end

@implementation ZJLog
singleton_m(Tool)

- (void)initData
{
    self.logEnable = YES;
    self.LogOutEnable = YES;     //默认向上输出
    self.saveEnable = NO;

    if (mCPrintfLevelValue == ZJLog_LEVEL_DEBUG) {   //DEBUG模式，其他默认设置debug级别关闭打印
#ifndef DEBUG
        mCPrintfLevelValue = -1;
#endif
    }
}

- (void)sendLogStr:(NSString *)content
{
    if (self.logEnable && self.LogOutEnable && self.delegate) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(didReceiveLogString:)]) {
            [self.delegate didReceiveLogString:content];
        }
    } else if (self.logEnable) {
#ifdef DEBUG
        NSLog(@"%@", content);
#endif
    }

    if (self.saveEnable) {
        [ZJLog writeLog:content];     //是否写入沙盒
    }
}

#pragma mark - Class API

+ (void)setDelegate:(id)delegate
{
    [ZJLog sharedTool].delegate = delegate;
}

+ (void)setLogOFF
{
    [ZJLog sharedTool].logEnable = false;
}

+ (void)setLevel:(ZJLog_LEVEL)level
{
    if (ZJLog_LEVEL_VERBOSE <= level && level <= ZJLog_LEVEL_ERROR) {
        mCPrintfLevelValue = (int)level;
        if (level == ZJLog_LEVEL_DEBUG) {   //DEBUG模式，其他默认设置debug级别关闭打印
#ifndef DEBUG
            mCPrintfLevelValue = -1;
#endif
        }
    }
}

+ (void)log:(NSString *_Nullable)content
{
    [[ZJLog sharedTool] sendLogStr:content];
}

#pragma mark - WriteLog

+ (void)writeClose
{
    if ([ZJLog sharedTool].saveEnable) {
        [[ZJLogWriteManager sharedWrite] close];
    }
}

+ (void)writeLog:(NSString *)content
{
    if ([ZJLog sharedTool].saveEnable) {
        [[ZJLogWriteManager sharedWrite] writeLog:content];
    }
}

+ (void)writeWrap
{
    if ([ZJLog sharedTool].saveEnable) {
        [[ZJLogWriteManager sharedWrite] writeWrap];
    }
}

+ (void)saveLog:(BOOL)isSave
{
    [ZJLog sharedTool].saveEnable = isSave;
}


@end
