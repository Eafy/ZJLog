package com.eafy.zjlogdemo;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;

import com.eafy.zjlog.ZJLog;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        ZJLog.d("-------->Log");
    }
}
