import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mp3_player/model/position_data.dart';
import 'package:mp3_player/resource/theme_colors/theme_colors.dart';

class AudioProgressBar extends StatelessWidget {
  const AudioProgressBar({
    super.key,
    required Stream<PositionData> positionDataStream,
    required AudioPlayer audioPlayer,
  })  : _positionDataStream = positionDataStream,
        _audioPlayer = audioPlayer;

  final Stream<PositionData> _positionDataStream;
  final AudioPlayer _audioPlayer;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _positionDataStream,
      builder: (context, snapshot) {
        final positionData = snapshot.data;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: ProgressBar(
            barHeight: 8.0,
            timeLabelPadding: 16.0,
            baseBarColor: ThemeColors.secondaryColor[400],
            bufferedBarColor: ThemeColors.secondaryColor,
            progressBarColor: ThemeColors.primaryColor[400],
            thumbColor: ThemeColors.primaryColor,
            timeLabelTextStyle: const TextStyle(color: ThemeColors.foregroundColor, fontWeight: FontWeight.w600),
            progress: positionData?.position ?? Duration.zero,
            buffered: positionData?.bufferedPosition ?? Duration.zero,
            total: positionData?.duration ?? Duration.zero,
            onSeek: _audioPlayer.seek,
          ),
        );
      },
    );
  }
}
