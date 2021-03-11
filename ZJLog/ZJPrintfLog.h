//
//  ZJPrintfLog.h
//  IOTCamera
//
//  Created by eafy on 2018/7/16.
//  Copyright © 2018年 ZJ. All rights reserved.
//

#ifndef ZJPrintfLog_h
#define ZJPrintfLog_h
#ifdef __cplusplus
extern "C" {
#endif
#include <stdio.h>
#include <string>

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
#define LOG_TAG "ZJLog"

extern void Java_com_eafy_zjlog_ZJlogJni_PrintAndroid(int prio, const char* tag, const char* fmt, ...);

#define CPrintf(...) Java_com_eafy_zjlog_ZJlogJni_PrintAndroid(ANDROID_LOG_DEBUG,LOG_TAG,__VA_ARGS__)
#define CPrintfV(...) Java_com_eafy_zjlog_ZJlogJni_PrintAndroid(ANDROID_LOG_VERBOSE,LOG_TAG,__VA_ARGS__)
#define CPrintfD(...) Java_com_eafy_zjlog_ZJlogJni_PrintAndroid(ANDROID_LOG_DEBUG,LOG_TAG,__VA_ARGS__)
#define CPrintfI(...) Java_com_eafy_zjlog_ZJlogJni_PrintAndroid(ANDROID_LOG_INFO,LOG_TAG,__VA_ARGS__)
#define CPrintfW(...) Java_com_eafy_zjlog_ZJlogJni_PrintAndroid(ANDROID_LOG_WARN,LOG_TAG,__VA_ARGS__)
#define CPrintfE(...) Java_com_eafy_zjlog_ZJlogJni_PrintAndroid(ANDROID_LOG_ERROR,LOG_TAG,__VA_ARGS__)
#define CPrintfLine() CPrintfE("%s---->%d", __func__, __LINE__)

#elif defined(__APPLE__)  //iOS

#include "ZJLogBridgeOC.h"

#else

#ifndef CPrintf
#define CPrintf printf
#define CPrintfV printf
#define CPrintfD printf
#define CPrintfI printf
#define CPrintfW printf
#define CPrintfE printf
#define CPrintfLine() printf("%s---->%d", __func__, __LINE__)
#endif

#endif  //end

#ifdef __cplusplus
}
#endif
#endif /* ZJPrintfLog_h */

#ifndef CLog_hpp
#define CLog_hpp

#define CLog CPrintf
#define CLogV CPrintfV
#define CLogD CPrintfD
#define CLogI CPrintfI
#define CLogW CPrintfW
#define CLogE CPrintfE
#define CLogLine CPrintfLine

#endif /* CLog_hpp */
