import 'dart:io';

import 'package:dropbox/dropbox.file.manager.dart';
import 'package:dropbox/entry.item.dart';
import 'package:dropbox/permission.utils.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
//import 'package:file_downloader/file_downloader.dart';

import 'file.downloader.dart';


class DropboxList extends StatefulWidget {
  List<EntryItem> items;

  DropboxList(List<EntryItem> items) {
    this.items = items;
    this.items.sort((a,b) => a.compareTo(b));
  }

  @override
  _DropboxListState createState() => _DropboxListState(items);

  static List<ListTile> getListTiles(List<EntryItem> items) {
    items.sort((a, b) => a.compareTo(b));

    List<ListTile> tiles = List();
    for (int i = 0; i < items.length; i++) {
      tiles.add(ListTile(title: Text(items[i].name)));
    }
    return tiles;
  }
}

class _DropboxListState extends State<DropboxList> {
  DropboxFileManager _fileManager = DropboxFileManager.instance;
  FileDownloader _fileDownloader = FileDownloader.instance;
  List<EntryItem> items;

  _DropboxListState(List<EntryItem> items) {
    this.items = items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dropbox'),
        backgroundColor: Colors.blueAccent,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.refresh),
              tooltip: 'Refresh',
              onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DropboxList(items),
                      ),
                    )
                  })
        ],
      ),
      body: Container(
        color: Colors.black,
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: items.length,
          itemBuilder: (context, index) => getListTile(items, index),
        ),
      )
    );
  }

  ListTile getListTile(List<EntryItem> items, int index) {
    EntryItem item;
    if (index <= items.length) {
      item = items[index];
    }
    return new ListTile(
      onTap: () async {
        if (item.type == Type.folder) {
          List<EntryItem> items = await _fileManager.getFileList(item.path);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DropboxList(items),
            ),
          );
        } else {
          PermissionUtils.ensurePermissions();
          String url = await _fileManager.getFileUrl(item.path);
          String taskId = await _fileDownloader.enqueue(
              remotePath: url,
              localPath: ''
          );
        }
      },
      leading: Icon(
        (item.type == Type.folder) ? Icons.folder : Icons.my_library_music,
        color: Colors.white,
      ),
      title: Text(
        item.name,
        style: TextStyle(
          color: Colors.white,
        ),
        textAlign: TextAlign.left,
      ),
      tileColor: Colors.black,
      selectedTileColor: Colors.blueGrey,
      hoverColor: Colors.blue,
    );
  }
}
