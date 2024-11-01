import 'package:file_picker/file_picker.dart';

Future<String?> pickFilePath(String? prevPath) async {
  FilePickerResult? file = await FilePicker.platform.pickFiles();

  if (file != null) {
    return file.files.single.path;
  } else {
    return prevPath;
  }
}

Future<String?> pickImgPath(String? prevPath) async {
  FilePickerResult? file = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'bmp', 'tiff']);

  if (file != null) {
    return file.files.single.path;
  } else {
    return prevPath;
  }
}

Future<String?> pickPNGPath(String? prevPath) async {
  FilePickerResult? file = await FilePicker.platform
      .pickFiles(type: FileType.custom, allowedExtensions: ['png']);

  if (file != null) {
    return file.files.single.path;
  } else {
    return prevPath;
  }
}
