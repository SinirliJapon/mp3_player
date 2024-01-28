import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:mp3_player/provider/audio_provider.dart';
import 'package:mp3_player/resource/styles/styles.dart';
import 'package:mp3_player/resource/theme_colors/theme_colors.dart';
import 'package:mp3_player/utils/functions.dart';
import 'package:mp3_player/widgets/current_track_info.dart';
import 'package:mp3_player/widgets/list_tile_trailing.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late AudioPlayer _audioPlayer;
  late AudioProvider _audioProvider;
  bool isPlaying = true;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _audioProvider = Provider.of<AudioProvider>(context, listen: false);
    Functions.init(_audioPlayer, _audioProvider);

    _audioPlayer.playerStateStream.listen((state) {
      setState(() {
        isPlaying = state.playing;
      });
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: Styles.audioBoxDecoration,
      child: Scaffold(
        appBar: AppBar(backgroundColor: Colors.transparent, title: const Text('Music Player'), foregroundColor: ThemeColors.foregroundColor),
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder<SequenceState?>(
                stream: _audioPlayer.sequenceStateStream,
                builder: (context, snapshot) {
                  final state = snapshot.data;
                  if (state?.sequence.isEmpty ?? true) {
                    return const Center(child: Text('Audioplayer is empty...', style: TextStyle(color: ThemeColors.foregroundColor)));
                  } else {
                    final playListLength = state!.sequence.length;
                    return ListView.builder(
                      itemCount: playListLength,
                      itemBuilder: (context, index) {
                        final metadata = state.sequence[index].tag as MediaItem;
                        final isCurrentItem = _audioPlayer.currentIndex == index;
                        return ListTile(
                          onTap: () => Functions.onTap(_audioPlayer, isPlaying, isCurrentItem, index),
                          leading: Text('${index + 1}', style: Styles.audioLeadingTextStyle),
                          title: Text(metadata.title),
                          subtitle: Text(metadata.artist ?? ''),
                          trailing: ListTileTrailing(isCurrentItem: isCurrentItem, isPlaying: isPlaying),
                          titleTextStyle: Styles.audioTitleTextStyle(isCurrentItem),
                          subtitleTextStyle: Styles.audioSubtitleTextStyle,
                          iconColor: ThemeColors.foregroundColor,
                        );
                      },
                    );
                  }
                },
              ),
            ),
            CurrentTrackInfo(audioPlayer: _audioPlayer, sequenceState: _audioPlayer.sequenceState, isPlaying: isPlaying),
          ],
        ),
      ),
    );
  }
}
