//
//  ZJLogBridgeC.m
//  ZJLog
//
//  Created by lzj<lizhijian_21@163.com> on 2019/1/8.
//  Copyright © 2019 ZJ. All rights reserved.
//

#import "ZJLogBridgeC.h"
#import "ZJLogEx.h"

void CPrintfSendCallback(char *log)
{
    [[ZJLog sharedTool] sendLogStr:[NSString stringWithUTF8String:log]];
}
