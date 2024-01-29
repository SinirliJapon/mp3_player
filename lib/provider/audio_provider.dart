import 'dart:convert';
import 'dart:core';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:mp3_player/model/audio.dart';

class AudioProvider extends ChangeNotifier {
  late bool isLoading = false;
  List<Audio> _audioSongsList = [];
  List<Audio> get audioSongsList => _audioSongsList;

  ConcatenatingAudioSource _playlists = ConcatenatingAudioSource(children: []);
  ConcatenatingAudioSource get playlists => _playlists;

  Future<void> fetchAudioSongs() async {
    isLoading = true;
    notifyListeners();
    try {
      final String jsonData = await rootBundle.loadString('assets/data/audio_songs.json');
      final List<dynamic> parsedJson = jsonDecode(jsonData);

      _audioSongsList = parsedJson.map((json) => Audio.fromJson(json)).toList();

      _playlists = (ConcatenatingAudioSource(
        children: _audioSongsList
            .map(
              (audio) => AudioSource.asset(
                audio.url,
                tag: MediaItem(
                  id: audio.id.toString(),
                  title: audio.title,
                  artist: audio.artist,
                  artUri: Uri.file(audio.image),
                ),
              ),
            )
            .toList(),
      ));
    } catch (e) {
      log('Error: $e');
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
