package com.eafy.zjlog;

import android.content.Context;
import android.os.Environment;
import android.util.Log;

import org.apache.log4j.Appender;
import org.apache.log4j.Level;
import org.apache.log4j.PatternLayout;
import org.apache.log4j.RollingFileAppender;

import java.io.File;
import java.io.IOException;

import de.mindpipe.android.logging.log4j.LogConfigurator;

public class ZJLogConfig {
    private String mTAG = "ZJLog";
    private Context mContext = null;
    private String mFileName = null;     //日志文件名称
    private String mPathDic = null;      //日志保存的上级目录
    private int mFileCount = 5;          //日志文件最大的数量
    private int mFileSize = 10;          //日志文件最大存储的大小(以M为单位)
    public boolean isDebug = true;     //日志输出开关（默认开启）
    public boolean isSave = false;     //是否保存日志到内置SD卡

    public ZJLogConfig setContext(Context context) {
        mContext = context;
        return this;
    }

    /**
     * 设置日志的tag标签
     *
     * @param tag 日志标签，默认"ZJLog"
     * */
    public ZJLogConfig setTAG(String tag) {
        mTAG = tag;
        return this;
    }

    /**
     * 获取日志的tag标签
     *
     * @return 日志标签
     * */
    public String getTAG() { return mTAG; }

    /**
     * 是否是DEBUG模式，在DEBUG模式下日志才会输出和保存
     *
     *  @param isDebug 是否启动
     * */
    public ZJLogConfig setIsDebug(boolean isDebug) {
        this.isDebug = isDebug;
        return this;
    }

    /**
     * 是否保存日志
     *
     * @param need 是否保存
     * */
    public ZJLogConfig setSaveEnable(boolean need) {
        this.isSave = need;
        return this;
    }

    /**
     * 设置IMEI，将会以文本名字_IMEI.log形式作为日志文件名
     * #需要在所有的日志打印前调用此接口，否则会产生默认文件
     *
     * @param name 文件名称
     * */
    public ZJLogConfig setFileName(String name) {
        mFileName = name;
        return this;
    }

    /**
     * 设置日志文件夹路径(默认会创建文件夹)
     * #需要在所有的日志打印前调用此接口，否则会产生默认文件
     *
     * @param pathDic 日志文件上级文件夹路径
     * */
    public ZJLogConfig setSavePathDic(String pathDic) {
        mPathDic = pathDic;
        return this;
    }

    /**
     * 设置日志存储的个数
     *
     * @param count 文件个数
     * */
    public ZJLogConfig setSaveFileCount(int count) {
        if (count > 0) mFileCount = count;
        return this;
    }

    /**
     * 设置日志存储的单个文件大小，以兆为单位
     *
     * @param size 单个文件大小，以兆为单位
     * */
    public ZJLogConfig setSaveFileSize(int size) {
        if (size > 0) mFileSize = size;
        return this;
    }

    public String getLogFileDir() {
        if (mPathDic != null) {
            if (!mPathDic.endsWith("/")) {
                mPathDic += File.separator;
            }
            return mPathDic;
        }

        String pathDic = Environment.getDownloadCacheDirectory().getAbsolutePath();
        if (mContext != null) {
            pathDic = mContext.getApplicationContext().getFilesDir().getAbsolutePath();
        }
        mPathDic = pathDic + File.separator + "ZJLog" + File.separator;
        return mPathDic;
    }

    public String getLogFilePath() {
        String filePath = getLogFileDir() + "ZJLog.log";
        if (mFileName != null) {
            filePath = getLogFileDir() + mFileName + ".log";
        }

        return filePath;
    }

    public boolean configure() {
        File filePath = new File(getLogFileDir());
        if (!filePath.exists() && !filePath.mkdirs()) {
            Log.e("ZJLog", "Failed to create new dir:" + getLogFileDir());
        }

        File file = new File(getLogFilePath());
        if (!file.exists()) {
            try {
                file.createNewFile();
            } catch (IOException e) {
                e.printStackTrace();
                Log.e("ZJLog", "Failed to create new file:" + getLogFilePath());
            }
        }

        LogConfigurator logConfigurator = new LogConfigurator();
        try {
            logConfigurator.setFileName(getLogFilePath());
            logConfigurator.setRootLevel(Level.ALL);
            logConfigurator.setLevel( "Eafy", Level.ALL);
            logConfigurator.setMaxFileSize(1024 * 1024 * mFileSize);   //文件的最大大小:10M
            logConfigurator.setMaxBackupSize(mFileCount);    //最多文件个数:5个
            logConfigurator.setUseLogCatAppender(true);
            logConfigurator.configure();
            return true;
        } catch (Throwable throwable) {
            this.isSave = false;
            logConfigurator.setResetConfiguration(true);
            Log.e(mTAG, "ZJLog config is error, Error:" + throwable);
        }

        return false;
    }

    public Appender appender() {
        RollingFileAppender rollingFileAppender = null;
        try {
            PatternLayout patternLayout = new PatternLayout("%d{yyy-MM-dd HH:mm:ss,SSS} [%p::%C:%x] %m%n");
            rollingFileAppender = new RollingFileAppender(patternLayout, getLogFilePath());
            rollingFileAppender.setMaximumFileSize(1024 * 1024 * mFileSize);
            rollingFileAppender.setMaxBackupIndex(mFileCount);
            rollingFileAppender.setName(mTAG);
        } catch (IOException e) {
            e.printStackTrace();
            Log.e(mTAG, "ZJLog file appender is error, Error:" + e.getMessage());
        }

        return rollingFileAppender;
    }
}
