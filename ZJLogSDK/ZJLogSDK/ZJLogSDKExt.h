//
//  ZJLogSDKExt.h
//  ZJLogSDK
//
//  此扩展文件目的：禁止外层项目进行访问，若不需要可和ConcoxLogController.h进行合并
//  Created by lzj<lizhijian_21@163.com> on 2018/5/10.
//  Copyright © 2018年 lzj<lizhijian_21@163.com>. All rights reserved.
//

#ifndef ZJLogSDKExt_h
#define ZJLogSDKExt_h

#import "ZJLogSDK.h"
#import "Singleton.h"

#define CLog(...) [[ZJLogSDK sharedTool] sendLogStr:[NSString stringWithFormat:__VA_ARGS__]]
extern void CPrintfCallback(const char *log);

@interface ZJLogSDK ()
singleton_h(Tool);

@property (nonatomic,weak) id<ZJLogSDKDelegate> delegate;

- (void)sendLogStr:(NSString *)content;

@end

#endif /* ZJLogSDKExt_h */
