import 'package:dropbox/dropbox.file.manager.dart';
import 'package:dropbox/dropbox.listbox.dart';
import 'package:dropbox/entry.item.dart';
import 'package:dropbox/permission.utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

Future<void> main() async {
  List<EntryItem> items = await DropboxFileManager.instance
      .getFileList(DropboxFileManager.DEFAULT_PATH);
  WidgetsFlutterBinding.ensureInitialized();
  FlutterDownloader.initialize();
  PermissionUtils.ensurePermissions();
  runApp(MyApp(items));
}

class MyApp extends StatelessWidget {
  List<EntryItem> items;
  MyApp(List<EntryItem> items) {
    this.items = items;
  }
  void setItems(List<EntryItem> items) {
    this.items = items;
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: DropboxList(items),
      title: 'Dropbox',
      theme: ThemeData(primarySwatch: Colors.lightBlue)
    );
  }
}
