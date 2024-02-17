import 'dart:async';
import 'dart:math';
import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_gif/flutter_gif.dart';
import 'package:get/get.dart';
import 'package:gif/gif.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:monkey_touch/Utils/app_images.dart';
import 'package:monkey_touch/main.dart';

class GameDashboardView extends StatefulWidget {
  const GameDashboardView({super.key});

  @override
  State<GameDashboardView> createState() => _GameDashboardViewState();
}

class _GameDashboardViewState extends State<GameDashboardView>
    with TickerProviderStateMixin {
  // late FlutterGifController controller1;
  late GifController controller1;
  int totalScore = 0;
  int turn = 10;

  Timer? timer;
  bool showGameOver = false;
  bool isShowDialog = false;
  dynamic number;

  showMonkeyTimer() {
    var data = sharedPrefs!.getString("level");
    timer = Timer.periodic(
        Duration(
            milliseconds: int.parse(data.toString()) == 2
                ? 400
                : int.parse(data.toString()) == 3
                    ? 200
                    : 700), (timer) {
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
    controller1 = GifController(vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller1.repeat(period: const Duration(milliseconds: 1200));
    });
    // controller1 = FlutterGifController(vsync: this);
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   controller1.repeat(
    //       min: 1, max: 5, period: const Duration(milliseconds: 300));
    // });

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
                "assets/game_img/game_dashboard.jpg",
                // "https://static.vecteezy.com/system/resources/previews/011/813/877/original/illustration-of-tropical-jungle-background-free-vector.jpg",
                // "https://media.istockphoto.com/id/166053319/vector/vector-cartoon-jungle-background-with-vines-and-palm-trees.jpg?s=612x612&w=0&k=20&c=tHnsMYuONFmuzll2vlqk8nNkQJKThKVi1s3UHxdIwMQ=",
                fit: BoxFit.cover,
                height: Get.height,
                width: Get.width,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Image.asset(
                      AppIcons.homeIcon,
                      height: 70,
                      width: 70,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
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
                                    ? Gif(
                                        image: const AssetImage(
                                            "assets/gif/monkey.gif"),
                                        controller: controller1,
                                        width: 100,
                                      )
                                    : const SizedBox(),
                                // number == i
                                //     ? GifImage(
                                //         image: const AssetImage(
                                //             "assets/gif/monkey.gif"),
                                //         controller: controller1,
                                //         width: 100,
                                //       )
                                //     : const SizedBox(),
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
                      AppIcons.playIcon,
                      // "assets/play.png",
                      width: 140,
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
                        totalScore >= 7
                            ? "assets/game_img/victory.png"
                            : "assets/game_over.png",
                        width: totalScore >= 7 ? 300 : 270,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      totalScore >= 7
                          ? Image.asset(
                              "assets/levels/level_up.png",
                              width: 300,
                            )
                          : const SizedBox(),
                      const SizedBox(
                        height: 20,
                      ),
                      BouncingWidget(
                        onPressed: () {
                          if (totalScore >= 7) {
                            var data = sharedPrefs?.getString("level");
                            sharedPrefs?.setString("level",
                                (int.parse(data.toString()) + 1).toString());
                          }
                          setState(() {
                            totalScore = 0;
                            turn = 10;
                            showGameOver = false;
                          });

                          showMonkeyTimer();
                        },
                        child: Image.asset(
                          AppImages.newGame,
                          width: 200,
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
              : const SizedBox(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    "assets/dialog.png",
                    // "assets/points_board.png",
                    width: 160,
                  ),
                  Text(
                    "SCORE \n $totalScore/10",
                    style: GoogleFonts.reggaeOne(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  )
                ],
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    "assets/dialog.png",
                    // "assets/points_board.png",
                    width: 160,
                  ),
                  Text(
                    "TURN - $turn",
                    style: GoogleFonts.reggaeOne(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
