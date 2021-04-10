import 'package:alpha_sample/utils/common_utils.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:flutter_native_admob/native_admob_options.dart';

class AdMobService {
  BannerAd _bannerAd;
  InterstitialAd _interstitialAd;
  String testDevice;
  int coins = 0;
  MobileAdTargetingInfo targetingInfo;
  static const _adUnitID = "ca-app-pub-3940256099942544/2247696110";
  final nativeAdmobController = NativeAdmobController();
  NativeAdmobOptions _nativeAdmobOptions = NativeAdmobOptions(
    showMediaContent: true,
  );

  factory AdMobService() => AdMobService._();

  AdMobService._() {
    initBannerAdMob();
  }

  initBannerAdMob() async {
    testDevice = await getDevicesId();
    FirebaseAdMob.instance.initialize(appId: FirebaseAdMob.testAppId);
    targetingInfo = MobileAdTargetingInfo(
      testDevices: testDevice != null ? <String>[testDevice] : null,
      keywords: <String>['foo', 'bar'],
      contentUrl: 'http://foo.com/bar.html',
      childDirected: true,
      nonPersonalizedAds: true,
    );

    _bannerAd = createBannerAd()..load();
    loadRewardedVideo();
    loadInterstitial();

    _bannerAd = createBannerAd()..load();

    //listen coins when click and view ads
    // RewardedVideoAd.instance.listener = (RewardedVideoAdEvent event, {String rewardType, int rewardAmount}) {
    //   print("RewardedVideoAd event $event");
    //   if (event == RewardedVideoAdEvent.rewarded) {
    //     coins += rewardAmount;
    //   }
    // };
  }

  Widget nativeAdMob({Widget errLoadAds}) {
    return new NativeAdmob(
      options: _nativeAdmobOptions,
      adUnitID: _adUnitID,
      error: errLoadAds,
      numberAds: 10,
      controller: nativeAdmobController,
      type: NativeAdmobType.full,
    );
  }

  void loadRewardedVideo() {
    RewardedVideoAd.instance.load(
        adUnitId: RewardedVideoAd.testAdUnitId, targetingInfo: targetingInfo);
  }

  void showRewardedVideo() {
    RewardedVideoAd.instance.show();
  }

  void loadInterstitial() {
    _interstitialAd?.dispose();
    _interstitialAd = createInterstitialAd()..load();
  }

  void showInterstitial() {
    _interstitialAd?.show();
  }

  void showBanner() {
    _bannerAd ??= createBannerAd();
    _bannerAd
      ..load()
      ..show();
  }

  void hideBanner() {
    _bannerAd.dispose();
    _bannerAd = null;
  }

  InterstitialAd createInterstitialAd() {
    return InterstitialAd(
      adUnitId: InterstitialAd.testAdUnitId,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        debugPrint("InterstitialAd event $event");
      },
    );
  }

  NativeAd createNativeAd() {
    return NativeAd(
      adUnitId: NativeAd.testAdUnitId,
      factoryId: 'adFactoryExample',
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("$NativeAd event $event");
      },
    );
  }

  BannerAd createBannerAd() {
    return BannerAd(
      adUnitId: BannerAd.testAdUnitId,
      size: AdSize.banner,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        debugPrint("BannerAd event $event");
      },
    );
  }
}
