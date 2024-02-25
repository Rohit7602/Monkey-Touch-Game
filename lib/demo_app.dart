import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class DemoAppView extends StatefulWidget {
  const DemoAppView({super.key});

  @override
  State<DemoAppView> createState() => _DemoAppViewState();
}

class _DemoAppViewState extends State<DemoAppView> {
  InterstitialAd? interstitialAd;
  RewardedAd? rewardedAd;

  @override
  void initState() {
    _showRewardAd();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ads Dekho"),
      ),
      body: Column(
        children: [
          // SizedBox(
          //   height: 200,
          //   width: Get.width,
          //   child: AdWidget(ad: AdsController.showBannerAd(context)),
          // ),
          ElevatedButton(
              onPressed: () {
                print("Error Ads");
                createInterestrialAd();
                // createRewardedAd();
                // _showRewardAd();
              },
              child: const Text("Interestrial Ads")),
          ElevatedButton(
              onPressed: () {
                print("Error Ads");

                createRewardedAd();
                // _showRewardAd();
              },
              child: const Text("Reward Ads"))
        ],
      ),
    );
  }

  createInterestrialAd() {
    return InterstitialAd.load(
      adUnitId: "ca-app-pub-3940256099942544/1033173712",
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          ad.show();
        },
        onAdFailedToLoad: (error) {
          print("Failed to load ad $error");
          interstitialAd = null;
        },
      ),
    );
  }

  void showInterestrialAd() {
    if (interstitialAd != null) {
      interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
          onAdFailedToShowFullScreenContent: (ad, error) {
        ad.dispose();
        createInterestrialAd();
      }, onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        createInterestrialAd();
      });
      interstitialAd!.show();
      interstitialAd = null;
    }
  }

  createRewardedAd() {
    print("Stpe 6");
    RewardedAd.load(
        adUnitId: "ca-app-pub-3940256099942544/5224354917",
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(onAdLoaded: (adLoad) {
          print("Stpe 7");
          print("Ad Load Checker ::: $adLoad");
          rewardedAd = adLoad;
        }, onAdFailedToLoad: (adFailed) {
          print("Stpe 8");
          print("Failed $adFailed");
          rewardedAd = null;
        }));

    Future.delayed(const Duration(seconds: 5), () {
      rewardedAd!.show(onUserEarnedReward: (ad, reward) {});
      rewardedAd = null;
    });
    print("Stpe 90");
  }

  void _showRewardAd() {
    print("Stpe 1");
    if (rewardedAd != null) {
      interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
          onAdFailedToShowFullScreenContent: (ad, error) {
        print("Stpe 2");
        ad.dispose();
        createRewardedAd();
      }, onAdDismissedFullScreenContent: (ad) {
        print("Stpe 3");
        ad.dispose();
        createRewardedAd();
      });
      print("Stpe 4");
      print("Stpe 5");
      rewardedAd!.show(onUserEarnedReward: (ad, reward) {});
      rewardedAd = null;
    } else {
      print("Else Case");
    }
  }
}
