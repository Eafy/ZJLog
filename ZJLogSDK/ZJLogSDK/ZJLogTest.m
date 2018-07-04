//
//  ZJLogTest.m
//  ZJLogSDK
//
//  Created by lzj<lizhijian_21@163.com> on 2018/7/4.
//  Copyright © 2018年 lzj<lizhijian_21@163.com>. All rights reserved.
//

#import "ZJLogTest.h"
#import "ZJLogSDKExt.h"
#import "ZJLogPrintf.h"

@implementation ZJLogTest

+ (void)test
{
    CLog(@"Test log out: %s-->%d", "Hello World", 1);
    CPrintf("Test log out: %s-->%d", "Hello World", 2);
}

@end
