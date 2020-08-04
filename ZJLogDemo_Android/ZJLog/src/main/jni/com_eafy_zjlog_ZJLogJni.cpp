#include "com_eafy_zjlog_ZJLogJni.h"
#include <stdio.h>
#include <malloc.h>

int mCPrintfLevelValue = CPrintf_VERBOSE;

void SetCPrintfLogLevel(int level)
{
    if (CPrintf_VERBOSE <= level && level <= CPrintf_ERROR) {
        mCPrintfLevelValue = level;
    }
}


#if defined(__ANDROID__) || defined(ANDROID)    //Android

static JavaVM *jmcpJVM = nullptr;
static jclass ccallj_listener_log = nullptr;
static jmethodID methodId_log = nullptr;
static jboolean bOpenLog = true;

static template <typename FUN> void doInJavaThread(FUN &&fun) {
    if (jmcpJVM != nullptr) {
        JNIEnv *env = nullptr;
        int status = jmcpJVM->GetEnv((void **)&env, JNI_VERSION_1_4);
        if (status != JNI_OK) {
            if (jmcpJVM->AttachCurrentThread(&env, NULL) != JNI_OK) {
                return;
            }
        }
        fun(env);
        if (status != JNI_OK) {
            jmcpJVM->DetachCurrentThread();
        }
    }
}

void Java_com_eafy_zjlog_ZJlogJni_PrintAndroid(int prio, const char* tag, const char* fmt, ...)
{
    if (!bOpenLog)
        return;

    char cLogBuffer[4097] = {0};
    va_list arg;
    va_start (arg, fmt);
    vsnprintf(cLogBuffer, 4096, fmt, arg);
    va_end (arg);

    if (jmcpJVM == NULL) {
        __android_log_print(prio, LOG_TAG, "%s", cLogBuffer);
    } else {
        doInJavaThread([&](JNIEnv *env) {
            if (env) {
                env->CallStaticVoidMethod(ccallj_listener_log, methodId_log, prio, env->NewStringUTF(cLogBuffer));
            }
        });
    }
}

JNIEXPORT void JNICALL Java_com_eafy_zjlog_ZJLogJni_OpenLog
        (JNIEnv *env, jclass, jboolean)
{
    if (env != nullptr && jmcpJVM == nullptr) {
        env->GetJavaVM(&jmcpJVM);

        jclass ccallj_log = env->FindClass("com/eafy/zjlog/ZJLog");
        if (ccallj_log == NULL) {
            jmcpJVM = nullptr;
            __android_log_print(CPrintf_ERROR, LOG_TAG, "%s", "Not find class: ZJLog");
            return;
        }

        ccallj_listener_log = (jclass) env->NewGlobalRef(ccallj_log);
        if (ccallj_listener_log) {
            methodId_log = env->GetStaticMethodID(ccallj_listener_log, "log", "(ILjava/lang/String;)V");
            if (methodId_log == nullptr) {
                jmcpJVM = nullptr;
                __android_log_print(CPrintf_ERROR, LOG_TAG, "%s", "Not find ZJLog methodId: log");
            }
        }
    }
}

#endif