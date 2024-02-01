import 'package:amharic_braille/application/models/translation_model.dart';
import 'package:amharic_braille/repository/play_audio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShowTranslation extends StatefulWidget {
  const ShowTranslation({super.key, required this.translationModel});
  final TranslationModel translationModel;

  @override
  State<ShowTranslation> createState() => _ShowTranslationState();
}

class _ShowTranslationState extends State<ShowTranslation> {
  int currentTab = 0;
  bool isPlaying = false;
  bool isPaused = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('See Translation'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  padding: const EdgeInsets.all(15),
                  child: Image.memory(widget.translationModel.image)),
              CupertinoSegmentedControl(
                  borderColor: Colors.blue,
                  pressedColor: Colors.blueGrey,
                  children: {
                    0: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: _buildButtons(index: 0, text: "Text")),
                    1: _buildButtons(text: "Voice", index: 1),
                    2: _buildButtons(text: "Braille", index: 2),
                  },
                  onValueChanged: ((value) => setState(() {
                        currentTab = value;
                      }))),
              const SizedBox(
                height: 10,
              ),
              currentTab == 1
                  ? Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.blue.shade100,
                      ),
                      child: Column(children: [
                        IconButton(
                          icon: Icon(
                            isPlaying == true ? Icons.pause : Icons.play_arrow,
                          ),
                          color: Colors.blue,
                          onPressed: () async {
                            debugPrint(
                                widget.translationModel.audio.toString());
                            isPlaying
                                ? AudioController().pause()
                                : isPaused
                                    ? AudioController().resume()
                                    : await AudioController().playAudio(
                                        widget.translationModel.audio);
                            setState(() {
                              isPlaying = !isPlaying;
                              isPaused = !isPaused;
                            });
                          },
                        ),
                        Text(
                          isPlaying == true
                              ? "Playing..."
                              : isPaused == true
                                  ? "Paused"
                                  : "Play Audio",
                          style: const TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ]),
                    )
                  : Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.black),
                          color: currentTab == 0
                              ? Colors.grey
                              : Colors.grey.shade300),
                      child: SelectableText(currentTab == 0
                          ? widget.translationModel.translation
                          : widget.translationModel.braille),
                    )
            ],
          ),
        ));
  }

  Widget _buildButtons({required int index, required String text}) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: currentTab == index ? Colors.black : Colors.grey.shade500,
      ),
    );
  }
}
