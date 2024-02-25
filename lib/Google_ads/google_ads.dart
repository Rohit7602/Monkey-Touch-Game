import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdsController {
  static BannerAd showBannerAd(context) {
    var bannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: "ca-app-pub-3940256099942544/6300978111",
        listener: BannerAdListener(
            onAdLoaded: (ad) {},
            onAdFailedToLoad: (ad, error) {
              ad.dispose();
            }),
        request: const AdRequest())
      ..load();

    return bannerAd;
  }

  static showAppOpenAd(context) async {
    await AppOpenAd.load(
        adUnitId: "ca-app-pub-3940256099942544/6300978111",
        request: const AdRequest(),
        adLoadCallback: AppOpenAdLoadCallback(
            onAdLoaded: (onAdLoaded) {
              onAdLoaded.show();
            },
            onAdFailedToLoad: (ad) {}),
        orientation: AppOpenAd.orientationPortrait);
  }

  static createInterestrialAd() {
    InterstitialAd.load(
      adUnitId: "ca-app-pub-3940256099942544/1033173712",
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          ad.show();
        },
        onAdFailedToLoad: (error) {},
      ),
    );
  }

  static createRewardedAd() {
    RewardedAd.load(
        adUnitId: "ca-app-pub-3940256099942544/5224354917",
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
            onAdLoaded: (adLoad) {
              adLoad.show(onUserEarnedReward: (ad, reward) {});
            },
            onAdFailedToLoad: (adFailed) {}));

    // Future.delayed(const Duration(seconds: 5), () {
    //   rewardedAd!.show(onUserEarnedReward: (ad, reward) {});
    //   rewardedAd = null;
    // });
  }
}
