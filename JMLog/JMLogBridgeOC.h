//
//  JMLogBridgeOC.h
//  JMLog
//
//  Created by lzj<lizhijian_21@163.com> on 2019/1/8.
//  Copyright © 2019 ZJ. All rights reserved.
//

#ifndef JMLogBridgeOC_h
#define JMLogBridgeOC_h

#include <stdio.h>
#include "JMLogBridgeC.h"

#ifndef CPrintfLevel
#define CPrintf_VERBOSE 0       //任意信息都打印(默认级别)
#define CPrintf_DEBUG 1         //DEBUG模式下打印
#define CPrintf_INFO 2          //提示性消息打印
#define CPrintf_WARN 3          //警告信息打印
#define CPrintf_ERROR 4         //错误信息打印
#define kNeedDifLevelValue      //需要声明级别变量
extern int mCPrintfLevelValue;  //当前级别
#endif

#define CPrintf(...)  \
{\
    if (mCPrintfLevelValue <= CPrintf_DEBUG) {\
        char cLogBuf[1024] = {0};\
        snprintf((char *)cLogBuf, 1024, __VA_ARGS__);\
        CPrintfSendCallback(cLogBuf);\
    }\
};

#define CPrintfV(...)  \
{\
    char cLogBuf[1024] = {0};\
    snprintf((char *)cLogBuf, 1024, __VA_ARGS__);\
    CPrintfSendCallback(cLogBuf);\
};

#define CPrintfD(...)  \
{\
    if (mCPrintfLevelValue <= CPrintf_DEBUG) {\
        char cLogBuf[1024] = {0};\
        snprintf((char *)cLogBuf, 1024, __VA_ARGS__);\
        CPrintfSendCallback(cLogBuf);\
    }\
};

#define CPrintfI(...)  \
{\
    if (mCPrintfLevelValue <= CPrintf_INFO) {\
        char cLogBuf[1024] = {0};\
        snprintf((char *)cLogBuf, 1024, __VA_ARGS__);\
        CPrintfSendCallback(cLogBuf);\
    }\
};

#define CPrintfW(...)  \
{\
    if (mCPrintfLevelValue <= CPrintf_WARN) {\
        char cLogBuf[1024] = {0};\
        snprintf((char *)cLogBuf, 1024, __VA_ARGS__);\
        CPrintfSendCallback(cLogBuf);\
    }\
};

#define CPrintfE(...)  \
{\
    if (mCPrintfLevelValue <= CPrintf_ERROR) {\
        char cLogBuf[1024] = {0};\
        snprintf((char *)cLogBuf, 1024, __VA_ARGS__);\
        CPrintfSendCallback(cLogBuf);\
    }\
};

#define CPrintfLine printf("%s---->%d\n", __func__, __LINE__);

#endif /* JMLogBridgeOC_h */
