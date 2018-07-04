//
//  ZJLogPrintf.h
//  ZJLogSDK
//
//  直接给C文件调用接口
//  Created by lzj<lizhijian_21@163.com> on 2018/5/11.
//  Copyright © 2018年 lzj<lizhijian_21@163.com>. All rights reserved.
//

#ifndef ZJLogPrintf_h
#define ZJLogPrintf_h

#include <stdio.h>
#include "ZJLogBridgeC.h"

#define CPrintf(...)  \
{\
    char cLogBuf[1024] = {0}; /*只支持1024个字节的输出(可自行调节大小)*/\
    snprintf((char *)cLogBuf, sizeof(cLogBuf), __VA_ARGS__);\
    CPrintfCallback(cLogBuf);\
};

#endif /* ZJLogPrintf_h */
