import 'dart:io';

import 'package:amharic_braille/application/braille_bloc/braille_bloc.dart';
import 'package:amharic_braille/application/braille_bloc/braille_events.dart';
import 'package:amharic_braille/application/braille_bloc/braille_state.dart';
import 'package:amharic_braille/presentation/widget/show_translation.dart';
import 'package:amharic_braille/utils/upload_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ImageUpload extends StatefulWidget {
  const ImageUpload({super.key});

  @override
  State<ImageUpload> createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  File? image;
  void _pickImage() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Choose an option"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: const Row(
                      children: [
                        Icon(Icons.photo_library, color: Colors.blue),
                        SizedBox(width: 10),
                        Text("Upload from Gallery"),
                      ],
                    ),
                    onTap: () async {
                      final res = await UploadServices().pickImageFromGallary();
                      setState(() {
                        Navigator.of(context).pop();
                        image = res;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    child: const Row(
                      children: [
                        Icon(Icons.camera_alt, color: Colors.blue),
                        SizedBox(width: 10),
                        Text("Take Photo"),
                      ],
                    ),
                    onTap: () async {
                      final res = await UploadServices().pickImageFromCamera();
                      setState(() {
                        image = res;
                        Navigator.of(context).pop();
                      });
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BrailleBloc, BrailleState>(
      listener: (context, state) {
        if (state is BrailleTranslationSuccess) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ShowTranslation(translationModel: state.translation)));
        } else if (state is BrailleTranslationFailure) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        return Center(
          child: image != null
              ? SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          Image.file(image!,
                              width: MediaQuery.of(context).size.width * 0.9),
                          Positioned(
                              top: 5,
                              right: 5,
                              child: InkWell(
                                onTap: _pickImage,
                                child: Image.asset(
                                    "assets/images/change_photo.png"),
                              ))
                        ],
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                          onPressed: () {
                            if (image != null) {
                              BlocProvider.of<BrailleBloc>(context).add(
                                  TranscribeBraille(imagePath: image!.path));
                            }
                          },
                          child: state.runtimeType == BrailleTranslationLoading
                              ? const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: CircularProgressIndicator(),
                                )
                              : const Text("Send Image"))
                    ],
                  ),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              "Upload Braille Image to translate to Amharic",
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.clip,
                              style:
                                  TextStyle(fontSize: 18, color: Colors.grey),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    InkWell(
                        onTap: _pickImage,
                        child: Image.asset(
                          "assets/images/insert_photo.png",
                        )),
                  ],
                ),
        );
      },
    );
  }
}
