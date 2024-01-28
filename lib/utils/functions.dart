import 'package:just_audio/just_audio.dart';
import 'package:mp3_player/provider/audio_provider.dart';

abstract class Functions {
  static Future<void> init(AudioPlayer audioPlayer, AudioProvider audioProvider) async {
    await audioPlayer.setLoopMode(LoopMode.all);
    await audioProvider.fetchAudioSongs();
    await audioPlayer.setAudioSource(audioProvider.playlists, initialIndex: 0);
  }

  static void onTap(AudioPlayer audioPlayer, bool isPlaying, bool isCurrentItem, int index) {
    if (isCurrentItem) {
      if (isPlaying) {
        audioPlayer.pause();
      } else {
        audioPlayer.play();
      }
    } else {
      audioPlayer.seek(Duration.zero, index: index);
      audioPlayer.play();
    }
  }
}
