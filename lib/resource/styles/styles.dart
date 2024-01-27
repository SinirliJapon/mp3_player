import 'package:flutter/material.dart';
import 'package:mp3_player/resource/theme_colors/theme_colors.dart';

abstract class Styles {
  static BoxDecoration audioBoxDecoration = const BoxDecoration(
    gradient: LinearGradient(
      colors: ThemeColors.backgroundGradient,
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      tileMode: TileMode.clamp,
    ),
  );

  static TextStyle audioTitleTextStyle(bool isPlaying, bool isCurrentItem) {
    return TextStyle(
      color: isPlaying ? ThemeColors.primaryColor : (isCurrentItem ? ThemeColors.primaryColor : ThemeColors.foregroundColor),
      fontWeight: isPlaying ? FontWeight.bold : FontWeight.bold,
    );
  }

  static TextStyle audioSubtitleTextStyle = const TextStyle(color: Colors.white, fontWeight: FontWeight.w500);
}
