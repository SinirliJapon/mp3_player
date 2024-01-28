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

  static TextStyle audioLeadingTextStyle = const TextStyle(color: ThemeColors.foregroundColor, fontSize: 18, fontWeight: FontWeight.w500);

  static TextStyle audioTitleTextStyle(bool isCurrentItem) {
    return TextStyle(
      color: isCurrentItem ? ThemeColors.primaryColor : ThemeColors.foregroundColor,
      fontWeight: isCurrentItem ? FontWeight.bold : FontWeight.normal,
      fontSize: 18,
    );
  }

  static TextStyle audioSubtitleTextStyle = const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16);

  static TextStyle trackTitleTextStyle = const TextStyle(color: ThemeColors.foregroundColor, fontWeight: FontWeight.bold, fontSize: 18);

  static TextStyle trackSubtitleTExtStyle = const TextStyle(color: ThemeColors.foregroundColor, fontWeight: FontWeight.w500, fontSize: 16);
}
