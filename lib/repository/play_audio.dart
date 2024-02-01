import 'dart:typed_data';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';

class AudioController {
  Future<void> playAudio(Uint8List audio) async {
    try {
      AudioPlayer audioPlayer = AudioPlayer();

      // Play the audio
      await audioPlayer.play(BytesSource(audio));
    } catch (e) {
      debugPrint("Error playing audio: $e");
    }
  }

  void pause() async {
    AudioPlayer audioPlayer = AudioPlayer();
    await audioPlayer.pause();
  }

  void resume() async {
    AudioPlayer audioPlayer = AudioPlayer();
    await audioPlayer.resume();
  }
}
