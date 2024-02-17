import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monkey_touch/home_page.dart';
import 'package:monkey_touch/main.dart';

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({super.key});

  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  @override
  void initState() {
    getInitialState();
    super.initState();
  }

  getInitialState() {
    Future.delayed(const Duration(milliseconds: 200), () {
      var data = sharedPrefs!.getString("level");

      if (data == null) {
        sharedPrefs?.setString("level", "1");
      }
      Get.to(const HomePageView());
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
