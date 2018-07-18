//
//  ZJLogSDK.m
//  ZJLogSDK
//
//  Created by lzj<lizhijian_21@163.com> on 2018/5/10.
//  Copyright © 2018年 lzj<lizhijian_21@163.com>. All rights reserved.
//

#import "ZJLogSDK.h"
#import "ZJLogSDKExt.h"

void CPrintfCallback(const char *log)
{
    [[ZJLogSDK sharedTool] sendLogStr:[NSString stringWithFormat:@"%s", log]];
}

@interface ZJLogSDK ()

@property (nonatomic,assign) BOOL logEnable;        //日志开关
@property (nonatomic,assign) BOOL LogOutEnable;     //日志输出开关

@end

@implementation ZJLogSDK
singleton_m(Tool);

- (void)initData
{
    //单例的初始化函数...>_>
    self.logEnable = YES;
    self.LogOutEnable = NO;     //默认不向上输出
}

- (void)sendLogStr:(NSString *)content
{
    if (self.logEnable && self.LogOutEnable) {
        __weak __typeof(self) weakSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(didReceiveLogString:)]) {
                [weakSelf.delegate didReceiveLogString:content];
            }
        });
    } else if (self.logEnable) {
        NSLog(@"%@", content);
    }
}

+ (void)setDelegate:(id)delegate
{
    [ZJLogSDK sharedTool].delegate = delegate;
}

+ (void)setLogOFF
{
    [ZJLogSDK sharedTool].logEnable = NO;
}

+ (void)setLogOut
{
    [ZJLogSDK sharedTool].LogOutEnable = YES;
}

@end
