// ignore_for_file: void_checks

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:monkey_touch/Bindings/main_bindings.dart';
import 'package:monkey_touch/audio/audio_player.dart';
import 'package:monkey_touch/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? sharedPrefs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPrefs = await SharedPreferences.getInstance();

  runApp(const MyApp());
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        // App is in the foreground
        return startSound();
      case AppLifecycleState.inactive:
        // App is inactive (not visible, but still running)
        return stopSound();
      case AppLifecycleState.paused:
        // App is in the background
        return stopSound();
      case AppLifecycleState.detached:
        // App is detached (not running)
        return stopSound();
      default:
        return;
    }
  }

  stopSound() {
    var data = Get.put(AudioPlayerClass());

    data.stopSound();
  }

  startSound() {
    var data = Get.put(AudioPlayerClass());

    data.startSound();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: InitialBindings(),
      home: const HomePageView(),
    );
  }
}
