// Copyright (c) 2020, AUTHORS file: Hai Le
package com.alpha.sample
import android.content.Intent
import com.zing.zalo.zalosdk.oauth.ZaloSDK;
import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity() {
    override fun onActivityResult(requestCode:Int, resultCode:Int, data: Intent) {
        super.onActivityResult(requestCode, resultCode, data)
        ZaloSDK.Instance.onActivityResult(this, requestCode, resultCode, data)
    }
}
