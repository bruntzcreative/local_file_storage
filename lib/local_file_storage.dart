library local_file_storage;

import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

Future<String> get localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<File> _getFile(String fileName) async {
  try {
    final String path = await localPath;

    return File('$path/$fileName');
  } catch (e) {
    print('error getting file $fileName: $e');
    return null;
  }
}

Future<void> writeFile(String fileName, String jsonString) async {
  try {
    final file = await _getFile(fileName);
    return await file.writeAsString(jsonEncode(jsonString));
  } catch (e) {
    print('error writing file $fileName: $e');
    return null;
  }
}

Future<String> readFile(String fileName) async {
  try {
    final file = await _getFile(fileName);
    if (file != null) {
      var contents = await file.readAsString();
      String fileData = await jsonDecode(contents);
      return fileData;
    }
    return null;
  } catch (e) {
    print('error reading file $fileName: $e');
    return null;
  }
}

Future<File> deleteFile(String fileName) async {
  final file = await _getFile(fileName);
  if (file != null) {
    try {
      return await file.delete();
    } catch (e) {
      print('error deleting file $fileName: $e');
      return null;
    }
  }
  return null;
}
