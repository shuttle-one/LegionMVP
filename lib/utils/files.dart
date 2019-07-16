import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';


class MyFiles {

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/#FILENAME');
  }

  Future<String> readCounter() async {
    try {
      final file = await _localFile;

      // Read the file
      String contents = await file.readAsString();

      return contents;
    } catch (e) {
      // If encountering an error, return 0
      return '';
    }
  }

  Future<void> writeCounter(String counter) async {
    final file = await _localFile;

    // Write the file
    file.writeAsString('$counter');
  }

}