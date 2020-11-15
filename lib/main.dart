import 'package:dropbox/dropbox.file.manager.dart';
import 'package:dropbox/dropbox_listbox.dart';
import 'package:dropbox/entry.item.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  List<EntryItem> items = await DropboxFileManager.instance
      .getFileList(DropboxFileManager.DEFAULT_PATH);
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
  Widget build(BuildContext context) =>
    MaterialApp(home: DropboxList(items),
      title: 'Dropbox',
      theme: ThemeData(primarySwatch: Colors.lightBlue)
    );
}
