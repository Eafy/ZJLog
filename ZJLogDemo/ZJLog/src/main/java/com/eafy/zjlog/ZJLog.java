package com.eafy.zjlog;

import android.os.Environment;
import android.util.Log;

import com.eafy.zjlog.ZJLogJni;

import org.apache.log4j.Level;
import org.apache.log4j.Logger;

import java.io.File;
import java.io.IOException;

import de.mindpipe.android.logging.log4j.LogConfigurator;

public class ZJLog {
    static {
        try {
            System.loadLibrary("ZJLog");
        } catch (UnsatisfiedLinkError ule) {
            Log.e("ZJLog", "loadLibrary ZJLog failed!");
        }
    }

    private static String mTAG = "ZJLog";
    private static Logger mLogger = null;
    private static boolean bIsDebug = true;     //日志输出开关（默认开启）
    private static boolean bIsSave = false;     //是否保存日志到内置SD卡
    private static boolean bIsFirstRun = true;  //是否第一次加载或输出
    private static String mFileName = null;     //日志文件名称
    private static String mPathDic = null;      //日志保存的上级目录
    private static int mFileCount = 5;          //日志文件最大的数量
    private static int mFileSize = 10;          //日志文件最大存储的大小(以M为单位)

    /**
     * 设置日志的tag标签
     *
     * @param tag 日志标签，默认"ZJLog"
     * */
    public static void setTAG(String tag) {
        mTAG = tag;
    }

    /**
     * 获取日志的tag标签
     *
     * @return 日志标签
     * */
    public static String getTAG() { return mTAG; }

    /**
     * 是否是DEBUG模式，在DEBUG模式下日志才会输出和保存
     *
     *  @param isDebug 是否启动
     * */
    public static void setIsDebug(boolean isDebug) {
        ZJLog.bIsDebug = isDebug;
    }

    /**
     * 是否保存日志
     *
     * @param need 是否保存
     * */
    public static void setSaveEnable(boolean need) {
        bIsSave = need;
    }

    /**
     * 设置IMEI，将会以文本名字_IMEI.log形式作为日志文件名
     * #需要在所有的日志打印前调用此接口，否则会产生默认文件
     *
     * @param name 文件名称
     * */
    public static void setFileName(String name) {
        mFileName = name;
        bIsFirstRun = true;
    }

    /**
     * 设置日志文件夹路径(默认会创建文件夹)
     * #需要在所有的日志打印前调用此接口，否则会产生默认文件
     *
     * @param pathDic 日志文件上级文件夹路径
     * */
    public static void setSavePathDic(String pathDic) {
        mPathDic = pathDic;
    }

    /**
     * 设置日志存储的个数
     *
     * @param count 文件个数
     * */
    public static void setSaveFileCount(int count) { if (count > 0) mFileCount = count; }

    /**
     * 设置日志存储的单个文件大小，以兆为单位
     *
     * @param size 单个文件大小，以兆为单位
     * */
    public static void setSaveFileSize(int size) { if (size > 0) mFileSize = size; }

    private static Logger getLoger(String tag) {
        if (bIsFirstRun) {
            ZJLogJni.Init();

            LogConfigurator logConfigurator = new LogConfigurator();
            File filePath = new File(getLogFilePath());
            if (!filePath.exists()) {
                filePath.mkdirs();
            }

            String fileName = getLogFilePath() + "ZJLog.log";
            if (mFileName != null) {
                fileName = getLogFilePath() + mFileName + ".log";
            }

            File file = new File(fileName);
            if (!file.exists()) {
                try {
                    file.createNewFile();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            logConfigurator.setFileName(fileName);
            logConfigurator.setRootLevel(Level.DEBUG);
            logConfigurator.setLevel("org.apache", Level.ERROR);
            logConfigurator.setMaxFileSize(1024 * 1024 * mFileSize);   //文件的最大大小:10M
            logConfigurator.setMaxBackupSize(mFileCount);    //最多文件个数:5个
            logConfigurator.configure();
            bIsFirstRun = false;
        }

        if (mLogger == null) {
            mLogger = Logger.getLogger(tag);
        }

        if (mLogger != null && !tag.equals(mLogger.getName())) {
            mLogger = Logger.getLogger(tag);
        }
        return mLogger;
    }

    private static final String getLogFilePath() {
        if (mPathDic != null) {
            if (!mPathDic.endsWith("/")) {
                mPathDic += File.separator;
            }
            return mPathDic;
        }
        return Environment.getExternalStorageDirectory().getAbsolutePath() + "/ZJLog" + File.separator;
    }

    private static boolean isStrEmpty(String str) {
        if (str == null || str.equals("")) {
            return true;
        }
        return false;
    }

    public static void v(String tag, String msg) {
        if (bIsDebug && msg != null) {
            if (isStrEmpty(tag)) {
                tag = mTAG;
            }

            Log.v(tag, msg);
        }
    }

    public static void v(String msg) {
        v(mTAG, msg);
    }

    public static void d(String tag, String msg) {
        if (bIsDebug && msg != null) {
            if (isStrEmpty(tag)) {
                tag = mTAG;
            }

            if (bIsSave) {
                getLoger(tag).debug(msg);
            } else {
                Log.d(tag, msg);
            }
        }
    }

    public static void d(String msg) {
        d(mTAG, msg);
    }

    public static void i(String tag, String msg) {
        if (bIsDebug && msg != null) {
            if (isStrEmpty(tag)) {
                tag = mTAG;
            }

            if (bIsSave) {
                getLoger(tag).info(msg);
            } else {
                Log.i(tag, msg);
            }
        }
    }

    public static void i(String msg) {
        i(mTAG, msg);
    }

    public static void w(String tag, String msg) {
        if (bIsDebug && msg != null) {
            if (isStrEmpty(tag)) {
                tag = mTAG;
            }

            if (bIsSave) {
                getLoger(tag).warn(msg);
            } else {
                Log.w(tag, msg);
            }
        }
    }

    public static void w(String msg) {
        w(mTAG, msg);
    }

    public static void e(String tag, String msg) {
        if (bIsDebug && msg != null) {
            if (isStrEmpty(tag)) {
                tag = mTAG;
            }

            if (bIsSave) {
                getLoger(tag).error(msg);
            } else {
                Log.e(tag, msg);
            }
        }
    }

    public static void e(String msg) {
        e(mTAG, msg);
    }

    public static void log(String msg) {
        ZJLog.e(mTAG, msg);
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
