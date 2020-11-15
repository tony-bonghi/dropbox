import 'package:flutter_downloader/flutter_downloader.dart';

class FileDownloader {
  static FileDownloader instance = new FileDownloader();

  FlutterDownloader.registerCallback(callback);

  void initialize() async {
    FlutterDownloader.initialize();
  }

  int enqueue() {
    final taskId = await FlutterDownloader.enqueue(
      url: '/',
      savedDir: '/',
      showNotification: true, // show download progress in status bar (for Android)
      openFileFromNotification: true, // click on notification to open downloaded file (for Android)
    );
    return taskId;
  }
}