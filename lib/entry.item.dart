
enum Type { file, folder }

class EntryItem implements Comparable {
  String id;
  String name;
  Type type;
  String path;
  bool isDownloadable = false;
  DateTime dateTime = DateTime.now();

  EntryItem(var element) {
    id = element['id'];
    name = element['name'];
    type = (element['.tag'] == Type.file.toString()) ? Type.file : Type.folder;
    path = element['path_display'];
    isDownloadable = "true" == element['is_downloadable'];
    if (element['client_modified'] != null) {
      dateTime = DateTime.parse(element['client_modified']);
    }
  }

  @override
  int compareTo(other) {
    EntryItem o = other as EntryItem;
    if (name == o.name && type == o.type) {
      return 0;
    }
    if (type == o.type) {
      return name.compareTo(o.name);
    }
    return (type == Type.folder && o.type == Type.file) ? -1 : 1;
  }
}