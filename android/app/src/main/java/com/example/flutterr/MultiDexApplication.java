package com.example.flutterr;

import android.content.Context;
import android.support.multidex.MultiDex;
import android.util.Log;

import io.flutter.app.FlutterApplication;

public class MultiDexApplication extends FlutterApplication {

	@Override
	public void onCreate() {
		super.onCreate();
		Log.d("MultiDexApplication", "" + System.currentTimeMillis());
	}

	@Override
	protected void attachBaseContext(Context base) {
		super.attachBaseContext(base);
		MultiDex.install(this);
	}

}
