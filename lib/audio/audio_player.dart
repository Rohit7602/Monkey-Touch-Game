import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';

class AudioPlayerClass extends GetxController {
  final AudioPlayer _player = AudioPlayer();
  AudioPlayer get getPlayer => _player;

  startSound() async {
    await _player.play(AssetSource("sound/bg_sound.mp3"));
    _player.onPlayerComplete.listen((event) {
      startSound();
    });
    update();
  }

  stopSound() async {
    await _player.stop();
    update();
  }
}
