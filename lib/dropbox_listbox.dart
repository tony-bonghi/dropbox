import 'dart:ui';
import 'package:dropbox/dropbox.file.manager.dart';
import 'package:dropbox/entry.item.dart';
import 'package:flutter/material.dart';

class DropboxListbox {
  static List<ListTile> getFileListTiles(List<EntryItem> items) {

    items.sort((a,b) => a.compareTo(b));

    List<ListTile> tiles = List();
    for (int i = 0; i < items.length; i++) {

      IconData icon = (items[i].type == Type.folder) ? Icons.folder : Icons.my_library_music;
      tiles.add(new ListTile(
        onTap: () => DropboxFileManager.instance().getDropboxFileList(items[i].path),
        leading: Icon(
          icon,
          color: Colors.white,
        ),
        title: Text(
          items[i].name,
          style: TextStyle(
            color: Colors.white,
          ),
          textAlign: TextAlign.left,
        ),
        tileColor: Colors.black,
        selectedTileColor: Colors.blueGrey,
        hoverColor: Colors.blue,
      ));
    }
    return tiles;
  }
}
