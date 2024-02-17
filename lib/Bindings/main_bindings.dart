import 'package:get/get.dart';
import 'package:monkey_touch/audio/audio_player.dart';

class InitialBindings with Bindings {
  @override
  void dependencies() {
    Get.put(AudioPlayerClass());
  }
}
