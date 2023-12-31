import 'dart:io';
import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gif/flutter_gif.dart';
import 'package:get/get.dart';
import 'package:monkey_touch/audio/audio_player.dart';
import 'package:monkey_touch/game_dashboard.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView>
    with TickerProviderStateMixin {
  late FlutterGifController controller1;
  bool isSound = false;

  @override
  void initState() {
    controller1 = FlutterGifController(vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller1.repeat(
          min: 1, max: 15, period: const Duration(milliseconds: 1200));
    });
    super.initState();
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
                child: GifImage(
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
                        if (isSound) {
                          isSound = false;
                          await AudioPlayerClass().stopSound();
                        } else {
                          isSound = true;
                          await AudioPlayerClass().startSound();
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
                  Get.to(const GameDashboardView());
                },
                child: Image.asset(
                  "assets/start.png",
                  width: 200,
                ),
              ),
              const SizedBox(
                height: 20,
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
