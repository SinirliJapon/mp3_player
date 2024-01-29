import 'package:flutter/material.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:mp3_player/provider/audio_provider.dart';
import 'package:mp3_player/screens/home_screen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationOngoing: true,
    androidShowNotificationBadge: true,
  );

  runApp(
    ChangeNotifierProvider(
      create: (_) => AudioProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}
