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

@interface ZJLog ()

@property (nonatomic, assign) BOOL enable;          //日志开关
@property (nonatomic, assign) BOOL saveEnable;      //日志保存开关
@property (nonatomic, assign) ZJLOG_LEVEL level;    //日志显示级别

@end

@implementation ZJLog
singleton_m(Tool)

- (void)initData
{
#ifdef DEBUG
    self.enable = YES;
#else
    self.enable = NO;
#endif
    self.saveEnable = NO;
    self.level = ZJLOG_LEVEL_VERBOSE;
    mCPrintfLevelValue = self.level;
}

- (void)sendLogStr:(NSString *)content
{
    if (!self.enable) return;

    if (self.delegate && [self.delegate respondsToSelector:@selector(didReceiveLogString:)]) {
        [self.delegate didReceiveLogString:content];
    } else {
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

+ (void)setLevel:(ZJLOG_LEVEL)level
{
    if (ZJLOG_LEVEL_VERBOSE <= level && level <= ZJLOG_LEVEL_ERROR) {
        [ZJLog sharedTool].level = level;
        mCPrintfLevelValue = level;
    }
}

+ (void)setEnable:(BOOL)enable
{
    [ZJLog sharedTool].enable = enable;
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

+ (void)setSave:(BOOL)isSave
{
    [ZJLog sharedTool].saveEnable = isSave;
}


@end
