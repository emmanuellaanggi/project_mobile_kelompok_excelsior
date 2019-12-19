package com.example.fira_app;

import android.app.Activity;
import android.os.Bundle;

public abstract class BaseActivity extends Activity {
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(getLayoutResourceId());
    }
    protected abstract int getLayoutResourceId();
}
