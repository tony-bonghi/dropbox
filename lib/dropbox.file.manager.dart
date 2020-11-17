import 'dart:io';

import 'package:dropbox/entry.item.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'file.downloader.dart';

class DropboxFileManager {

  static const DROPBOX_BASE_URL = "https://api.dropboxapi.com/2";
  static const DROPBOX_LIST_FOLDER_URL = DROPBOX_BASE_URL + "/files/list_folder";
  static const DROPBOX_GET_TEMPORARY_LINK = DROPBOX_BASE_URL + "/files/get_temporary_link";
  static const String DEFAULT_PATH = "/My Dropbox Move/Documents/My n-Track Recordings";
  static const AUTH_TOKEN = '4iN64mwPm1YAAAAAAAAAAWuU3n2tE3EU8_-7G6_53qPKPJebGlerX4yy0OLkWZL2';
  static DropboxFileManager instance = DropboxFileManager();

  String currentPath;

  Future<List<EntryItem>> refresh() async {
    return getFileList(currentPath);
  }

  void updateEntriesByPath(List<EntryItem> entries, String path) async {
    List<EntryItem> items = await DropboxFileManager.instance.getFileList(path);
    entries.clear();
    entries.addAll(items);
  }

  Future<List<EntryItem>> getFileList(path) async {
    currentPath = path;
    String LIST_FILES_REQUEST = jsonEncode({
      "path": path,
      "recursive": false,
      "include_deleted": false,
      "include_has_explicit_shared_members": false,
      "include_mounted_folders": true,
      "include_non_downloadable_files": true
    });
    http.Response filesResponse = await http.post(DROPBOX_LIST_FOLDER_URL,
        headers: {
          'Authorization': 'Bearer ' + AUTH_TOKEN,
          'Accept': 'application/json',
          'Content-Type': 'application/json; charset=utf-8'
        },
        body: LIST_FILES_REQUEST
    );

    List<EntryItem> files = [];
    if (filesResponse.statusCode == 200) {
      List entries = jsonDecode(filesResponse.body)['entries'];
      entries.forEach((element) {
         files.add(EntryItem(element));
      });
    }
    print(filesResponse.body);
    return files;
  }

  Future<String> getFileUrl(path) async {
    http.Response rsp = await http.post(DROPBOX_GET_TEMPORARY_LINK,
        headers: {
          'Authorization': 'Bearer ' + AUTH_TOKEN,
          'Accept': 'application/json',
          'Content-Type': 'application/json; charset=utf-8'
        },
        body: jsonEncode( { "path": path })
    );

    print(path);
    print(rsp.statusCode);
    print(rsp.body);
    if (rsp.statusCode == 200) {
      return jsonDecode(rsp.body)['link'];
    }
    return null;
  }
}
