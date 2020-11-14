import 'package:dropbox/dropbox.file.manager.dart';
import 'package:dropbox/dropbox_listbox.dart';
import 'package:dropbox/entry.item.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  DropboxFileManager fileManager = DropboxFileManager();
  List<EntryItem> files = await fileManager
      .getDropboxFileList(DropboxFileManager.DEFAULT_PATH);
  runApp(MyApp(files));
}

class MyApp extends StatelessWidget {
  List<EntryItem> files;
  MyApp(files) {
    this.files = files;
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dropbox',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue
      ),
      home: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              tooltip: 'Refresh',
              onPressed: () =>
                  DropboxFileManager.instance().refreshDropboxFileList(),
            ),
          ],
          title: Text('Dropbox')),
        body: BodyLayout(files),
      ),
    );
  }
}

class BodyLayout extends StatelessWidget {
  List<EntryItem> files;
  BodyLayout(List<EntryItem> files) {
    this.files = files;
  }
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: ListTile.divideTiles(
          tiles: DropboxListbox.getFileListTiles(files),
          color: Colors.redAccent
      ).toList(),
    );
  }
}
