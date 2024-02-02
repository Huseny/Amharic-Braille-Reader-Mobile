import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';

class AudioController {
  AudioPlayer audioPlayer = AudioPlayer();

  Future<void> playAudio(File audio) async {
    try {
      Uint8List audioBytes = await audio.readAsBytes();
      audioPlayer.play(BytesSource(audioBytes));
    } catch (e) {
      debugPrint("Error playing audio: $e");
    }
  }

  void pause() async {
    await audioPlayer.pause();
    debugPrint("audio paused");
  }
}
