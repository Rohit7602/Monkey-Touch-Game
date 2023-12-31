import 'dart:async';
import 'dart:math';
import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gif/flutter_gif.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:monkey_touch/audio/audio_player.dart';

class GameDashboardView extends StatefulWidget {
  const GameDashboardView({super.key});

  @override
  State<GameDashboardView> createState() => _GameDashboardViewState();
}

class _GameDashboardViewState extends State<GameDashboardView>
    with TickerProviderStateMixin {
  late FlutterGifController controller1;

  int totalScore = 0;
  int turn = 10;

  Timer? timer;
  bool showGameOver = false;
  bool isShowDialog = false;
  dynamic number;

  showMonkeyTimer() {
    timer = Timer.periodic(const Duration(milliseconds: 700), (timer) {
      getMonkeyNumber();
    });
  }

  getMonkeyNumber() {
    var getNumber = Random().nextInt(8);
    setState(() {
      number = getNumber;
    });
  }

  @override
  void initState() {
    controller1 = FlutterGifController(vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller1.repeat(
          min: 1, max: 5, period: const Duration(milliseconds: 300));
    });

    super.initState();
  }

  showGameNotStartDialog() {
    setState(() {
      isShowDialog = true;
    });
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        isShowDialog = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Stack(
            children: [
              Image.asset(
                "assets/bg.jpg",
                fit: BoxFit.cover,
                height: Get.height,
                width: Get.width,
              ),
              Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(bottom: 90),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.asset(
                              "assets/points_board.png",
                              width: 270,
                            ),
                            Text(
                              "SCORE - $totalScore/10",
                              style: GoogleFonts.reggaeOne(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                            )
                          ],
                        ),
                      ),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset(
                            "assets/points_board.png",
                            width: 270,
                          ),
                          Text(
                            "TURN - $turn",
                            style: GoogleFonts.reggaeOne(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          )
                        ],
                      ),
                    ],
                  ),
                  GridView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: 9,
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3),
                      itemBuilder: (context, i) {
                        return BouncingWidget(
                          onPressed: () {
                            if (timer != null) {
                              if (turn == 1) {
                                setState(() {
                                  turn--;
                                  showGameOver = true;
                                  timer!.cancel();
                                });
                              } else {
                                if (number == i) {
                                  setState(() {
                                    turn--;
                                    totalScore++;
                                  });
                                } else {
                                  setState(() {
                                    turn--;
                                  });
                                }
                              }
                            } else {
                              showGameNotStartDialog();
                            }
                          },
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: const BoxDecoration(),
                            child: Stack(
                              children: [
                                Image.asset(
                                  "assets/wooden.png",
                                  fit: BoxFit.cover,
                                ),
                                number == i
                                    ? GifImage(
                                        image: const AssetImage(
                                            "assets/gif/monkey.gif"),
                                        controller: controller1,
                                        width: 100,
                                      )
                                    : const SizedBox(),
                              ],
                            ),
                          ),
                        );
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  BouncingWidget(
                    scaleFactor: 4,
                    onPressed: () {
                      if (timer == null) {
                        showMonkeyTimer();
                      }
                    },
                    child: Image.asset(
                      "assets/play.png",
                      width: 200,
                    ),
                  ),
                ],
              ),
            ],
          ),
          showGameOver
              ? Container(
                  height: Get.height,
                  width: Get.width,
                  color: Colors.black.withOpacity(0.8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        number >= 7
                            ? "assets/you_win.png"
                            : "assets/game_over.png",
                        width: 270,
                      ),
                      BouncingWidget(
                        onPressed: () {
                          setState(() {
                            totalScore = 0;
                            turn = 10;
                            showGameOver = false;
                          });
                          showMonkeyTimer();
                        },
                        child: Image.asset(
                          "assets/reload.png",
                          width: 90,
                        ),
                      ),
                    ],
                  ),
                )
              : const SizedBox(),
          isShowDialog
              ? Container(
                  alignment: Alignment.topCenter,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        "assets/dialog.png",
                        width: 250,
                      ),
                      Text(
                        "Please Start\nThe Game !!",
                        style: GoogleFonts.reggaeOne(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                      ),
                    ],
                  ),
                )
              : const SizedBox()
        ],
      ),
    );
  }
}
