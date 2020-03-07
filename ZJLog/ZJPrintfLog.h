//
//  ZJPrintfLog.h
//  IOTCamera
//
//  Created by lzj<lizhijian_21@163.com> on 2018/7/16.
//  Copyright © 2018年 Jimi. All rights reserved.
//

#ifndef ZJPrintfLog_h
#define ZJPrintfLog_h

#ifndef CPrintfLevel
#define CPrintfLevel
#define CPrintf_VERBOSE 0       //任意信息都打印(默认级别)
#define CPrintf_DEBUG 1         //DEBUG模式下打印
#define CPrintf_INFO 2          //提示性消息打印
#define CPrintf_WARN 3          //警告信息打印
#define CPrintf_ERROR 4         //错误信息打印
extern int mCPrintfLevelValue;
extern void SetCPrintfLogLevel(int level);
#endif


#if defined(__ANDROID__) || defined(ANDROID)    //Android

#include <android/log.h>
#include "com_jimi_jimivideo_log_JMLogUtilJni.h"

#elif defined(__APPLE__)  //iOS

#include "ZJLogBridgeOC.h"

#else

#ifndef CPrintf
#define CPrintfD printf
#define CPrintfV printf
#define CPrintfD printf
#define CPrintfI printf
#define CPrintfW printf
#define CPrintfE printf
#endif

#endif  //end

#endif /* ZJPrintfLog_h */
