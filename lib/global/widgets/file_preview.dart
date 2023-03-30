import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../config.dart';
import '../utils/styles.dart';
import '../utils/supported_locales.dart';

class FilePreview extends StatefulWidget {
  /// Widget used for displaying basic info about selected file
  const FilePreview(this.filePath, {super.key});
  final String? filePath;

  @override
  State<FilePreview> createState() => _FilePreviewState();
}

class _FilePreviewState extends State<FilePreview> {
  // Field is used for re-rendering if language is changed
  // ignore: unused_field
  Locale _currentLocale = SupportedLocales.english;

  @override
  Widget build(BuildContext context) {
    _currentLocale = context.locale;

    String fileName = 'err.noFile';
    String fileSize = '';
    Icon fileIcon = Icon(Icons.insert_drive_file_rounded,
        color: Theme.of(context).colorScheme.tertiary);

    if (widget.filePath != null) {
      try {
        final File file = File(widget.filePath!);

        fileName = file.uri.pathSegments.last;
        final int fileBytes = file.lengthSync();

        fileIcon = chooseIcon(getExtension(fileName), context);
        fileSize = countFileSize(fileBytes);
      } catch (e) {
        fileName = 'err.fileNotFound';
        fileIcon = Icon(
          Icons.error_rounded,
          color: themeHolder.currentThemeMode() == ThemeMode.light
              ? Colors.red
              : Colors.redAccent,
        );
      }
    }

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.tertiaryContainer,
        borderRadius: const BorderRadius.all(
          Radius.circular(Styles.borderRadius),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            fileIcon,
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: Text(fileName).tr(),
              ),
            ),
            Text(
              fileSize,
              style: TextStyle(
                  fontFamily: GoogleFonts.robotoCondensed().fontFamily,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

/// Returns file extension. If file don't have any, returns empty String.
String getExtension(String fileName) {
  if (fileName.contains('.')) {
    return fileName.split('.').last;
  } else {
    return '';
  }
}

/// Counts file size from given bytes.
String countFileSize(int bytes) {
  List<String> units = ['B', 'kB', 'MB', 'GB', 'TB', 'PB', 'EB'];
  double size = bytes.toDouble();
  int unitIndex = 0;
  while (size > 1024) {
    size /= 1024;
    unitIndex++;
    if (unitIndex > 6) {
      return "∞";
    }
  }

  return '${double.parse((size).toStringAsFixed(2))} ${units[unitIndex]}';
}

/// Returns icon based on file extension.
Icon chooseIcon(String extension, BuildContext context) {
  IconData iconData = Icons.insert_drive_file_rounded;
  switch (extension) {
    case 'dot':
    case 'doc':
    case 'docx':
    case 'dotx':
    case 'gdoc':
    case 'odp':
    case 'odt':
    case 'pdf':
    case 'tex':
    case 'txt':
    case 'xls':
    case 'xlsx':
      iconData = Icons.description_rounded;
      break;

    case 'key':
    case 'pps':
    case 'ppt':
    case 'pptx':
      iconData = Icons.slideshow_rounded;
      break;

    case 'c':
    case 'class':
    case 'cpp':
    case 'csharp':
    case 'css':
    case 'dart':
    case 'go':
    case 'h':
    case 'htm':
    case 'html':
    case 'java':
    case 'js':
    case 'php':
    case 'py':
    case 'rd':
    case 'rs':
    case 'swift':
    case 'ts':
    case 'xhtml':
      iconData = Icons.code_rounded;
      break;

    case 'json':
      iconData = Icons.data_object_outlined;
      break;

    case 'ai':
    case 'bmp':
    case 'gif':
    case 'ico':
    case 'jpeg':
    case 'jpg':
    case 'png':
    case 'svg':
    case 'tif':
    case 'tiff':
    case 'webp':
      iconData = Icons.image_rounded;
      break;

    case 'aif':
    case 'mid':
    case 'midi':
    case 'mp3':
    case 'mpa':
    case 'ogg':
    case 'wav':
    case 'wma':
    case 'wpl':
      iconData = Icons.audio_file_rounded;
      break;

    case 'avi':
    case 'flv':
    case 'mkv':
    case 'mp4':
    case 'mpg':
    case 'mpeg':
    case 'rm':
    case 'webm':
    case 'wmv':
      iconData = Icons.video_file_rounded;
      break;

    case '7z':
    case 'gz':
    case 'pkg':
    case 'rar':
    case 'tar':
    case 'z':
    case 'zip':
      iconData = Icons.folder_zip_rounded;
      break;

    case 'email':
    case 'eml':
    case 'emlx':
    case 'msg':
    case 'vcf':
      iconData = Icons.email_rounded;
      break;
  }

  return Icon(iconData, color: Theme.of(context).colorScheme.primary);
}
