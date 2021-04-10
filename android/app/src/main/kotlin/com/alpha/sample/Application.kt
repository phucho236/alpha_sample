// Copyright (c) 2020, AUTHORS file: Hai Le
package com.alpha.sample

import io.flutter.app.FlutterApplication
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugins.firebasemessaging.FlutterFirebaseMessagingService


import io.flutter.view.FlutterMain;
import android.app.Activity;
import com.zing.zalo.zalosdk.oauth.ZaloSDKApplication;

class Application : FlutterApplication(), PluginRegistry.PluginRegistrantCallback {

    override fun onCreate() {
        super.onCreate()
        FlutterFirebaseMessagingService.setPluginRegistrant(this);
        ZaloSDKApplication.wrap(this);
        FlutterMain.startInitialization(this);
    }

    override fun registerWith(registry: PluginRegistry?) {
        if (registry != null) {
            FirebaseCloudMessagingPluginRegistrant.registerWith(registry)
            FlutterLocalNotificationPluginRegistrant.registerWith(registry)
        }
    }

    private var mCurrentActivity: Activity? = null

    override fun getCurrentActivity(): Activity? {
        return mCurrentActivity
    }

    override fun setCurrentActivity(mCurrentActivity: Activity?) {
        this.mCurrentActivity = mCurrentActivity
    }
}