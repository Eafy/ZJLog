package com.eafy.zjlog;

import android.util.Log;

public class ZJLogJni {
    static {
        try {
            System.loadLibrary("ZJLog");
        } catch (UnsatisfiedLinkError ule) {
            Log.d(ZJLog.config.getTAG(), ule.getMessage());
        }
    }

    public static native void OpenLog(boolean bOpen);
}
