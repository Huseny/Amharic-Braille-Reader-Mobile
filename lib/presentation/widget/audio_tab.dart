import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioTab extends StatefulWidget {
  const AudioTab({super.key, required this.audio});
  final File audio;

  @override
  State<AudioTab> createState() => _AudioTabState();
}

class _AudioTabState extends State<AudioTab> {
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  final AudioPlayer audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();

    setAudio();
    audioPlayer.onDurationChanged.listen((event) {
      setState(() {
        duration = event;
      });
    });

    audioPlayer.onPositionChanged.listen((event) {
      setState(() {
        position = event;
      });
    });

    audioPlayer.onPlayerStateChanged.listen((event) {
      setState(() {
        isPlaying = event == PlayerState.playing;
      });
    });
  }

  Future<void> setAudio() async {
    try {
      audioPlayer.setReleaseMode(ReleaseMode.stop);
      audioPlayer.setSource(BytesSource(widget.audio.readAsBytesSync()));
    } catch (e) {
      debugPrint("Error playing audio: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Hear the Braille Tranlation",
            style: TextStyle(color: Color(0xff585A66)),
          ),
          const SizedBox(
            height: 10,
          ),
          Slider(
              min: 0,
              max: duration.inSeconds.toDouble(),
              value: position.inSeconds.toDouble(),
              onChanged: (value) async {
                position = Duration(seconds: value.toInt());
                await audioPlayer.seek(position);
              }),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${position.inMinutes}:${position.inSeconds}",
                  style: const TextStyle(color: Colors.black),
                ),
                Text(
                  "${duration.inMinutes}:${duration.inSeconds}",
                  style: const TextStyle(color: Colors.black),
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  if (isPlaying) {
                    audioPlayer.pause();
                    setState(() {
                      isPlaying = false;
                    });
                  } else {
                    audioPlayer.resume();
                    setState(() {
                      isPlaying = true;
                    });
                  }
                },
                icon: Icon(
                  isPlaying ? Icons.pause_circle : Icons.play_circle,
                  size: 50,
                ),
              ),
              IconButton(
                  onPressed: () {
                    audioPlayer.stop();
                    setState(() {
                      isPlaying = false;
                    });
                  },
                  icon: const Icon(
                    Icons.stop_circle,
                    size: 50,
                  ))
            ],
          )
        ],
      ),
    );
  }
}
