import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:lottie/lottie.dart';
import 'package:mp3_player/model/position_data.dart';
import 'package:mp3_player/provider/audio_provider.dart';
import 'package:mp3_player/resource/styles/styles.dart';
import 'package:mp3_player/widgets/audio_progress_bar.dart';
import 'package:mp3_player/widgets/controls.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late AudioPlayer _audioPlayer;
  late AudioProvider _audioProvider;

  Stream<PositionData> get _positionDataStream => Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
        _audioPlayer.positionStream,
        _audioPlayer.bufferedPositionStream,
        _audioPlayer.durationStream,
        (position, bufferedPosition, duration) => PositionData(position, bufferedPosition, duration ?? Duration.zero),
      );

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _audioProvider = Provider.of<AudioProvider>(context, listen: false);
    _init();
  }

  Future<void> _init() async {
    await _audioPlayer.setLoopMode(LoopMode.all);
    await _audioProvider.fetchAudioSongs();
    await _audioPlayer.setAudioSource(_audioProvider.playlists, initialIndex: 0);
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
        appBar: AppBar(backgroundColor: Colors.transparent),
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder<SequenceState?>(
                stream: _audioPlayer.sequenceStateStream,
                builder: (context, snapshot) {
                  final state = snapshot.data;
                  if (state?.sequence.isEmpty ?? true) {
                    return const SizedBox();
                  }
                  final playListLength = state!.sequence.length;

                  return ListView.builder(
                    itemCount: playListLength,
                    itemBuilder: (context, index) {
                      final metadata = state.sequence[index].tag as MediaItem;
                      final isCurrentItem = _audioPlayer.currentIndex == index;
                      final isPlaying = isCurrentItem && _audioPlayer.playing;

                      return ListTile(
                        onTap: () {
                          if (isCurrentItem) {
                            if (isPlaying) {
                              _audioPlayer.pause();
                            } else {
                              _audioPlayer.play();
                            }
                          } else {
                            _audioPlayer.seek(Duration.zero, index: index);
                            _audioPlayer.play();
                          }
                        },
                        leading: ClipRRect(borderRadius: BorderRadius.circular(10.0), child: Image(image: AssetImage(metadata.artUri.toString()))),
                        title: Text(metadata.title, style: Styles.audioTitleTextStyle(isPlaying, isCurrentItem)),
                        trailing: isPlaying ? Lottie.asset('assets/icons/soundwave.json') : const SizedBox(),
                        subtitle: Text(metadata.artist ?? ''),
                        subtitleTextStyle: Styles.audioSubtitleTextStyle,
                        iconColor: Colors.white,
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            AudioProgressBar(positionDataStream: _positionDataStream, audioPlayer: _audioPlayer),
            Controls(audioPlayer: _audioPlayer),
          ],
        ),
      ),
    );
  }
}
