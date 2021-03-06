library local_file_storage;

import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

Future<String> get localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<File> _getFileRead(String fileName) async {
  try {
    final String path = await localPath;
    return await File('$path/$fileName').exists() ? File('$path/$fileName') : null;
  } catch (e) {
    print('error getting file $fileName: $e');
    return null;
  }
}

Future<File> _getFileWrite(String fileName) async {
  try {
    final String path = await localPath;

    return File('$path/$fileName');
  } catch (e) {
    print('error getting file $fileName: $e');
    return null;
  }
}

Future<File> writeFile(String fileName, var jsonString) async {
  try {
    final file = await _getFileWrite(fileName);
    return await file.writeAsString(jsonEncode(jsonString));
  } catch (e) {
    print('error writing file $fileName: $e');
    return null;
  }
}

Future readFile(String fileName) async {
  try {
    final file = await _getFileRead(fileName);
    if (file != null) {
      var contents = await file.readAsString();
      var fileData = await jsonDecode(contents);
      return fileData;
    }
    return null;
  } catch (e) {
    print('error reading file $fileName: $e');
    return null;
  }
}

Future<File> deleteFile(String fileName) async {
  final file = await _getFileRead(fileName);
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
