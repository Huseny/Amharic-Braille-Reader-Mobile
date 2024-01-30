import 'dart:io';

import 'package:amharic_braille/application/braille_bloc/braille_bloc.dart';
import 'package:amharic_braille/application/braille_bloc/braille_events.dart';
import 'package:amharic_braille/application/braille_bloc/braille_state.dart';
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
  Future<void> _pickImage() async {
    final res = await UploadServices().pickImageFromGallary();
    setState(() {
      image = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BrailleBloc, BrailleState>(
      listener: (context, state) {
        if (state is BrailleTranslationSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("translated successfully")));
          debugPrint(state.props.toString());
        } else if (state is BrailleTranslationFailure) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.props[0].toString())));
        }
      },
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: image != null
                  ? Stack(
                      children: [
                        Image.file(image!,
                            height: MediaQuery.of(context).size.width * 0.7),
                        Positioned(
                            top: 5,
                            right: 5,
                            child: InkWell(
                              onTap: _pickImage,
                              child:
                                  Image.asset("assets/images/change_photo.png"),
                            ))
                      ],
                    )
                  : InkWell(
                      onTap: _pickImage,
                      child: Image.asset("assets/images/insert_photo.png"),
                    ),
            ),
            ElevatedButton(
                onPressed: () {
                  if (image != null) {
                    BlocProvider.of<BrailleBloc>(context)
                        .add(TranscribeBraille(imagePath: image!.path));
                  }
                },
                child: state.runtimeType == BrailleTranslationLoading
                    ? const CircularProgressIndicator()
                    : const Text("Send Image"))
          ],
        );
      },
    );
  }
}
