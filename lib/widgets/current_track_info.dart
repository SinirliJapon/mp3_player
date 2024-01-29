import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:marquee/marquee.dart';
import 'package:mp3_player/resource/styles/styles.dart';
import 'package:mp3_player/resource/theme_colors/theme_colors.dart';
import 'package:mp3_player/utils/audio_stream_utils.dart';
import 'package:mp3_player/widgets/audio_progress_bar.dart';
import 'package:mp3_player/widgets/controls.dart';

class CurrentTrackInfo extends StatelessWidget {
  final AudioPlayer audioPlayer;
  final SequenceState? sequenceState;
  final bool isPlaying;

  const CurrentTrackInfo({Key? key, required this.audioPlayer, required this.sequenceState, required this.isPlaying}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final currentIndex = audioPlayer.currentIndex ?? 0;
    final currentMetadata = sequenceState?.sequence[currentIndex].tag as MediaItem?;

    if (currentMetadata == null) {
      return const SizedBox.shrink();
    } else {
      return Column(
        children: [
          Container(
            width: screenWidth,
            color: ThemeColors.backgroundBlack,
            child: ListTile(
              contentPadding: const EdgeInsets.all(0),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image(image: AssetImage(currentMetadata.artUri.toString()), height: 50, width: 50, fit: BoxFit.cover),
              ),
              title: SizedBox(
                height: 25,
                child: Marquee(
                  text: currentMetadata.title,
                  style: Styles.trackTitleTextStyle,
                  scrollAxis: Axis.horizontal,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  blankSpace: 20.0,
                  velocity: 35.0,
                  startPadding: 8.0,
                  accelerationCurve: Curves.linear,
                ),
              ),
              subtitle: Text(currentMetadata.artist ?? '', style: Styles.trackSubtitleTExtStyle),
              trailing: SizedBox(width: screenWidth / 2.6, child: Controls(audioPlayer: audioPlayer)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
            child: AudioProgressBar(positionDataStream: AudioStreamUtils.getPositionDataStream(audioPlayer), audioPlayer: audioPlayer),
          ),
        ],
      );
    }
  }
}
