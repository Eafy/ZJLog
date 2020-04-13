//
// Created by lzj<lizhijian_21@163.com> on 2020-03-16.
//

#include "com_eafy_zjlog_ZJLogJni.h"
#include <stdio.h>
#include <malloc.h>
#include <android/log.h>

static JavaVM *jmcpJVM = nullptr;
static jclass ccallj_listener_log = nullptr;
static jmethodID methodId_log = nullptr;

template <typename FUN> void doInJavaThread(FUN &&fun) {
    if (jmcpJVM != nullptr) {
        JNIEnv *env = nullptr;
        int status = jmcpJVM->GetEnv((void **)&env, JNI_VERSION_1_4);
        if (status != JNI_OK) {
            if (jmcpJVM->AttachCurrentThread(&env, nullptr) != JNI_OK) {
                return;
            }
        }
        fun(env);
        if (status != JNI_OK) {
            jmcpJVM->DetachCurrentThread();
        }
    }
}

JNIEXPORT void JNICALL Java_com_eafy_zjlog_ZJLogJni_Init
(JNIEnv *env, jclass)
{
    if (jmcpJVM == nullptr) {
        env->GetJavaVM(&jmcpJVM);

        jclass ccallj_log = env->FindClass("com/eafy/zjlog/ZJLog");
        if (ccallj_log == nullptr) {
            return;
        }

        ccallj_listener_log = (jclass) env->NewGlobalRef(ccallj_log);
        if (ccallj_listener_log) {
            methodId_log = env->GetStaticMethodID(ccallj_listener_log, "log",
                                                  "(ILjava/lang/String;)V");
        }
    }
}

JNIEXPORT void JNICALL Java_com_eafy_zjlog_ZJLogJni_Release
        (JNIEnv *env, jclass)
{
    if (ccallj_listener_log != nullptr) {
        env->DeleteGlobalRef(ccallj_listener_log);
        ccallj_listener_log = nullptr;
    }

    jmcpJVM = nullptr;
    methodId_log = nullptr;
}

JNIEXPORT void JNICALL Java_com_eafy_zjlog_ZJlogJni_PrintAndroid
        (int prio, const char* tag, const char* fmt, ...)
{
    if (tag == nullptr)
        return;

    char cLogBuffer[513] = {0};
    va_list arg;
    va_start (arg, fmt);
    vsnprintf(cLogBuffer, 512, fmt, arg);
    va_end (arg);

    if (jmcpJVM == nullptr || methodId_log == nullptr) {
        __android_log_print(prio, tag, "%s", cLogBuffer);
    } else {
        doInJavaThread([&](JNIEnv *env) {
            if (env) {
                env->CallStaticVoidMethod(ccallj_listener_log, methodId_log, prio, env->NewStringUTF(cLogBuffer));
            }
        });
    }
}
