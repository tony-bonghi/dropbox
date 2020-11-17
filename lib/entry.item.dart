
enum Type { file, folder }

class EntryItem implements Comparable {
  String id;
  String name;
  Type type;
  String path;
  bool isDownloadable = false;
  DateTime dateTime = DateTime.now();

  EntryItem(var element) {
    if (element == null) return;
    id = element['id'];
    id = id.substring(3);
    name = element['name'];
    type = (element['.tag'] == 'file') ? Type.file : Type.folder;
    print(type.toString());
    path = element['path_display'];
    isDownloadable = "true" == element['is_downloadable'];
    if (element['client_modified'] != null) {
      dateTime = DateTime.parse(element['client_modified']);
    }
  }

  @override
  int compareTo(other) {
    EntryItem o = other as EntryItem;
    if (type == o.type) {
      return name.compareTo(o.name);
    }
    return (type == Type.folder) ? -1 : 1;
  }
}