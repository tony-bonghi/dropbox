import 'package:dropbox/entry.item.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DropboxFileManager {

  static const LIST_FOLDER_URL = "https://api.dropboxapi.com/2/files/list_folder";
  static const String DEFAULT_PATH = "/My Dropbox Move/Documents/My n-Track Recordings";
  static DropboxFileManager singleton = DropboxFileManager();

  String currentPath;

  static DropboxFileManager instance() {
    return singleton;
  }

  Future<List<EntryItem>> refreshDropboxFileList() async {
     return getDropboxFileList(currentPath);
  }
  Future<List<EntryItem>> getDropboxFileList(path) async {
    currentPath = path;
    String LIST_FILES_REQUEST = jsonEncode({
      "path": path,
      "recursive": false,
      "include_deleted": false,
      "include_has_explicit_shared_members": false,
      "include_mounted_folders": true,
      "include_non_downloadable_files": true
    });
    http.Response filesResponse = await http.post(LIST_FOLDER_URL,
        headers: {
          'Authorization': 'Bearer 4iN64mwPm1YAAAAAAAAAAWuU3n2tE3EU8_-7G6_53qPKPJebGlerX4yy0OLkWZL2',
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
}
