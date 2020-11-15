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

class MyAppx extends StatelessWidget {
  List<EntryItem> items;
  bool flip = false;

  MyApp(List<EntryItem> items) {
    this.items = items;
  }

  void setItems(List<EntryItem> items) {
    this.items = items;
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
                  {
                    DropboxFileManager.instance.refresh()
                  }
              ),
            ],
            title: Text('Dropbox')),
        body: BodyLayout(items),
      ),
    );
  }
}

class BodyLayout extends StatelessWidget {
  List<EntryItem> items;

  BodyLayout(var items) {
    this.items = items;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: ListTile.divideTiles(
          tiles: DropboxList.getListTiles(items),
          color: Colors.redAccent
      ).toList(),
    );
  }
}
