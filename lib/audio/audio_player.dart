import 'package:audioplayers/audioplayers.dart';

class AudioPlayerClass {
  AudioPlayer player = AudioPlayer();

  startSound() async {
    await player.play(AssetSource("sound/bg_sound.mp3"));
  }

  stopSound() async {
    await player.stop();
    await player.dispose();
  }
}
