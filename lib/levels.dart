import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monkey_touch/Utils/app_images.dart';
import 'package:monkey_touch/main.dart';

class AppLevelsView extends StatelessWidget {
  AppLevelsView({super.key});

  var level = sharedPrefs?.getString("level");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "assets/home.jpg",
            fit: BoxFit.cover,
            height: Get.height,
            width: Get.width,
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Image.asset(
                    AppIcons.homeIcon,
                    height: 70,
                    width: 70,
                  ),
                ),
                SizedBox(
                  height: Get.height * .2,
                ),
                Image.asset(AppImages.level),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Flexible(
                        flex: 1,
                        child: Image.asset(
                          AppIcons.level1,
                        )),
                    Flexible(
                        flex: 1,
                        child: Stack(
                          children: [
                            Image.asset(AppIcons.level2),
                            int.parse(level.toString()) <= 1
                                ? Image.asset(
                                    AppIcons.locked_img,
                                    width: Get.width * 0.1,
                                  )
                                : const SizedBox()
                          ],
                        )),
                    Flexible(
                      flex: 1,
                      child: Stack(
                        children: [
                          Image.asset(AppIcons.level3),
                          int.parse(level.toString()) <= 2
                              ? Image.asset(
                                  AppIcons.locked_img,
                                  width: Get.width * 0.1,
                                )
                              : const SizedBox()
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
