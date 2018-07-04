//
//  ZJLogBridgeC.m
//  ZJLogSDK
//
//  Created by lzj<lizhijian_21@163.com> on 2018/5/11.
//  Copyright © 2018年 lzj<lizhijian_21@163.com>. All rights reserved.
//

#import "ZJLogBridgeC.h"
#import "ZJLogSDKExt.h"

void CPrintfCallback(const char *log)
{
    [[ZJLogSDK sharedTool] sendLogStr:[NSString stringWithFormat:@"%s", log]];
}
