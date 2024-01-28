import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mp3_player/resource/theme_colors/theme_colors.dart';

class ListTileTrailing extends StatelessWidget {
  final bool isCurrentItem;
  final bool isPlaying;

  const ListTileTrailing({super.key, required this.isCurrentItem, required this.isPlaying});

  @override
  Widget build(BuildContext context) {
    if (isCurrentItem) {
      if (isPlaying) {
        return ColorFiltered(
          colorFilter: const ColorFilter.mode(ThemeColors.primaryColor, BlendMode.srcATop),
          child: Lottie.asset('assets/icons/soundwave.json'),
        );
      } else {
        return const Icon(Icons.play_arrow_rounded);
      }
    } else {
      return const SizedBox();
    }
  }
}
