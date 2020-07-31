//
//  JMLog.m
//  JMLog
//
//  Created by lzj<lizhijian_21@163.com> on 2019/1/2.
//  Copyright © 2019 ZJ. All rights reserved.
//

#import "JMLog.h"
#import "JMLogEx.h"
#import "JMLogWriteManager.h"

void CPrintfSendCallback(char *log)
{
    [[JMLog sharedTool] sendLogStr:[NSString stringWithFormat:@"%s", log]];
}

@interface JMLog ()

@property (nonatomic,assign) BOOL logEnable;        //日志开关
@property (nonatomic,assign) BOOL LogOutEnable;     //日志向上输出开关
@property (nonatomic,assign) BOOL saveEnable;       //日志保存开关

@end

@implementation JMLog
singleton_m(Tool)

- (void)initData
{
    self.logEnable = YES;
    self.LogOutEnable = YES;     //默认向上输出
    self.saveEnable = NO;

    if (mCPrintfLevelValue == JMLog_LEVEL_DEBUG) {   //DEBUG模式，其他默认设置debug级别关闭打印
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
        [JMLog writeLog:content];     //是否写入沙盒
    }
}

#pragma mark - Class API

+ (void)setDelegate:(id)delegate
{
    [JMLog sharedTool].delegate = delegate;
}

+ (void)setLogOFF
{
    [JMLog sharedTool].logEnable = false;
}

+ (void)setLevel:(JMLog_LEVEL)level
{
    if (JMLog_LEVEL_VERBOSE <= level && level <= JMLog_LEVEL_ERROR) {
        mCPrintfLevelValue = (int)level;
        if (level == JMLog_LEVEL_DEBUG) {   //DEBUG模式，其他默认设置debug级别关闭打印
#ifndef DEBUG
            mCPrintfLevelValue = -1;
#endif
        }
    }
}

+ (void)log:(NSString *_Nullable)content
{
    [[JMLog sharedTool] sendLogStr:content];
}

#pragma mark - WriteLog

+ (void)writeClose
{
    if ([JMLog sharedTool].saveEnable) {
        [[JMLogWriteManager sharedWrite] close];
    }
}

+ (void)writeLog:(NSString *)content
{
    if ([JMLog sharedTool].saveEnable) {
        [[JMLogWriteManager sharedWrite] writeLog:content];
    }
}

+ (void)writeWrap
{
    if ([JMLog sharedTool].saveEnable) {
        [[JMLogWriteManager sharedWrite] writeWrap];
    }
}

+ (void)saveLog:(BOOL)isSave
{
    [JMLog sharedTool].saveEnable = isSave;
}


@end
