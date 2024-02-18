// ignore_for_file: void_checks

import 'dart:io';
import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gif/gif.dart';
import 'package:monkey_touch/Utils/app_images.dart';
import 'package:monkey_touch/audio/audio_player.dart';
import 'package:monkey_touch/game_dashboard.dart';
import 'package:monkey_touch/levels.dart';
import 'package:monkey_touch/main.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView>
    with TickerProviderStateMixin {
  late GifController controller1;
  bool isSound = true;

  @override
  void initState() {
    controller1 = GifController(vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller1.repeat(period: const Duration(milliseconds: 1200));
    });
    initialState();

    super.initState();
  }

  initialState() {
    var data = Get.find<AudioPlayerClass>();
    data.startSound();
    sharedPrefs?.setString("level", "1");
    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Stack(
            children: [
              Image.asset(
                "assets/home.jpg",
                fit: BoxFit.cover,
                height: Get.height,
                width: Get.width,
              ),
              Positioned(
                left: 0,
                top: 0,
                child: Gif(
                  image: const AssetImage(
                    "assets/monkey_home.gif",
                  ),
                  controller: controller1,
                  width: 100,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 80,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    BouncingWidget(
                      onPressed: () async {
                        var data = Get.find<AudioPlayerClass>();
                        if (isSound) {
                          isSound = false;
                          data.stopSound();
                        } else {
                          isSound = true;

                          data.startSound();
                        }

                        setState(() {});
                      },
                      child: Image.asset(
                        isSound
                            ? "assets/sound_on.png"
                            : "assets/sound_off.png",
                        width: 60,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              BouncingWidget(
                onPressed: () {
                  // sharedPrefs?.clear();
                  Get.to(const GameDashboardView());
                },
                child: Image.asset(
                  "assets/start.png",
                  width: 200,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              BouncingWidget(
                onPressed: () {
                  Get.to(AppLevelsView());
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      AppImages.level_board,
                      width: 200,
                    ),
                    const Text(
                      "Levels",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )
                  ],
                ),
              ),
              BouncingWidget(
                onPressed: () {
                  exit(0);
                },
                child: Image.asset(
                  "assets/exit.png",
                  width: 200,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
