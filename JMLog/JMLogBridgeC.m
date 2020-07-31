//
//  JMLogBridgeC.m
//  JMLog
//
//  Created by lzj<lizhijian_21@163.com> on 2019/1/8.
//  Copyright © 2019 ZJ. All rights reserved.
//

#import "JMLogBridgeC.h"
#import "JMLogEx.h"

void CPrintfSendCallback(char *log)
{
    [[JMLog sharedTool] sendLogStr:[NSString stringWithUTF8String:log]];
}
