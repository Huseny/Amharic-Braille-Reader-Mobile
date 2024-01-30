import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

class UploadServices {
  Future<File?> pickFile(FileType fileType, bool allowMutliple,
      {List<String>? allowedExtensions}) async {
    final result = await FilePicker.platform.pickFiles(
      type: fileType,
      allowedExtensions: allowedExtensions,
      allowMultiple: allowMutliple,
    );

    if (result != null && result.files.isNotEmpty) {
      final path = result.files.first.path;
      if (path != null) {
        return File(path);
      }
    }
    return null;
  }

  Future<File?> pickImageFromCamera() async {
    try {
      XFile? pickedImage = await ImagePicker().pickImage(
        source: ImageSource.camera,
        imageQuality: 100,
      );

      if (pickedImage != null) {
        final path = pickedImage.path;
        return File(path);
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  Future<File?> pickImageFromGallary() async {
    try {
      XFile? pickedImage = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 100,
      );

      if (pickedImage != null) {
        final path = pickedImage.path;
        return File(path);
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }
}
