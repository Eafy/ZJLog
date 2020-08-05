package com.eafy.zjlog;

import android.os.Looper;
import android.util.Log;

import org.apache.log4j.Appender;
import org.apache.log4j.Logger;

public class ZJLog {
    private static Logger mLogger = null;
    public static ZJLogConfig config = new ZJLogConfig();

    private static ZJLogConfig getConfig() {
        if (config == null) {
            config = new ZJLogConfig();
        }

        return config;
    }

    /**
     * 获取Logger保存对象
     *
     * @param config 配置对象
     * @param tag    打印TAG
     */
    private static Logger getLoger(ZJLogConfig config, String tag) {
        if (config != null && mLogger == null) {
            config.configure();
            mLogger = Logger.getLogger(tag);
            if (config != ZJLog.getConfig()) {
                mLogger.addAppender(config.appender());
                mLogger.setAdditivity(false);   //避免重复输出2次日志
            }
            ZJLogJni.OpenLog(true);
        }

        if (mLogger != null && !tag.equals(mLogger.getName())) {
            mLogger = Logger.getLogger(tag);
            Appender apr =  mLogger.getAppender(tag);
            if (apr == null) {
                if (config != ZJLog.getConfig()) {
                    mLogger.addAppender(config.appender());
                    mLogger.setAdditivity(false);   //避免重复输出2次日志
                }
            }
        }
        return mLogger;
    }

    /**
     * 判断是否需要保存日志，并进行保存
     *
     * @param config 配置对象
     * @param tag    打印TAG
     * @param msg    日志
     * @return 是否保存
     */
    private static boolean saveToLoger(ZJLogConfig config, String tag, String msg, int prio) {
        if (config != null && config.isDebug && msg != null) {
            if (config.isSave) {
                switch (prio) {
                    case Log.ERROR:
                        getLoger(config, tag).error(msg); break;
                    case Log.INFO:
                        getLoger(config, tag).info(msg); break;
                    case Log.WARN:
                        getLoger(config, tag).warn(msg); break;
                    default:
                        getLoger(config, tag).debug(msg); break;
                }
                return true;
            }
        }

        return false;
    }

    public static void v(ZJLogConfig config, String tag, String msg) {
        if (!saveToLoger(config, tag, msg, Log.VERBOSE)) {
            Log.v(tag, msg);
        }
    }

    public static void d(ZJLogConfig config, String tag, String msg) {
        if (!saveToLoger(config, tag, msg, Log.DEBUG)) {
            Log.d(tag, msg);
        }
    }

    public static void i(ZJLogConfig config, String tag, String msg) {
        if (!saveToLoger(config, tag, msg, Log.INFO)) {
            Log.i(tag, msg);
        }
    }

    public static void w(ZJLogConfig config, String tag, String msg) {
        if (!saveToLoger(config, tag, msg, Log.WARN)) {
            Log.w(tag, msg);
        }
    }

    public static void e(ZJLogConfig config, String tag, String msg) {
        if (!saveToLoger(config, tag, msg, Log.ERROR)) {
            Log.e(tag, msg);
        }
    }

    public static void v(String tag, String msg) {
        v(getConfig(), tag, msg);
    }

    public static void d(String tag, String msg) {
        d(getConfig(), tag, msg);
    }

    public static void i(String tag, String msg) {
        i(getConfig(), tag, msg);
    }

    public static void w(String tag, String msg) {
        w(getConfig(), tag, msg);
    }

    public static void e(String tag, String msg) { e(getConfig(), tag, msg); }

    public static void v(String msg) {
        v(getConfig(), getConfig().getTAG(), msg);
    }

    public static void d(String msg) {
        d(getConfig(), getConfig().getTAG(), msg);
    }

    public static void i(String msg) {
        i(getConfig(), getConfig().getTAG(), msg);
    }

    public static void w(String msg) {
        w(getConfig(), getConfig().getTAG(), msg);
    }

    public static void e(String msg) {
        e(getConfig(), getConfig().getTAG(), msg);
    }

    public static void log(int prio, String msg) {
        if (prio == 2) {  //ANDROID_LOG_VERBOSE
            v(msg);
        } else if (prio == 3) {
            d(msg);
        } else if (prio == 4) {
            i(msg);
        } else if (prio == 5) {
            w(msg);
        } else if (prio == 6) {
            e(msg);
        } else {
            d(msg);
        }
    }

    public static void log(String msg) {
        ZJLog.d(getConfig(), getConfig().getTAG(), msg);
    }

    public static void printBytes(String logHint, byte[] buffer) {
        String finalString = logHint;
        for (int i = 0; i < buffer.length; i++) {
            String hex = Integer.toHexString(buffer[i] & 0xFF);
            if (hex.length() == 1) {
                hex = '0' + hex;
            }

            if (finalString == null) {
                finalString = hex;
            } else {
                finalString += (" " + hex);
            }
        }
        ZJLog.d(finalString);
    }
}
