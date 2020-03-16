//
// Created by lzj<lizhijian_21@163.com> on 2018/12/5.
//

#ifndef ZJLOGBRIDGEJNI_H
#define ZJLOGBRIDGEJNI_H

#include <android/log.h>
#include "com_eafy_zjlog_ZJLogJni.h"

JNIEXPORT void JNICALL Java_com_eafy_zjlog_ZJLogJni_PrintAndroid(int prio, const char* tag, const char* fmt, ...);

#define LOG_TAG "ZJLog"
#define CPrintfD(...) Java_com_eafy_zjlog_ZJLogJni_PrintAndroid(ANDROID_LOG_DEBUG,LOG_TAG,__VA_ARGS__)
#define CPrintfV(...) Java_com_eafy_zjlog_ZJLogJni_PrintAndroid(ANDROID_LOG_VERBOSE,LOG_TAG,__VA_ARGS__)
#define CPrintfD(...) Java_com_eafy_zjlog_ZJLogJni_PrintAndroid(ANDROID_LOG_DEBUG,LOG_TAG,__VA_ARGS__)
#define CPrintfI(...) Java_com_eafy_zjlog_ZJLogJni_PrintAndroid(ANDROID_LOG_INFO,LOG_TAG,__VA_ARGS__)
#define CPrintfW(...) Java_com_eafy_zjlog_ZJLogJni_PrintAndroid(ANDROID_LOG_WARN,LOG_TAG,__VA_ARGS__)
#define CPrintfE(...) Java_com_eafy_zjlog_ZJLogJni_PrintAndroid(ANDROID_LOG_ERROR,LOG_TAG,__VA_ARGS__)

#endif //ZJLOGBRIDGEJNI_H
