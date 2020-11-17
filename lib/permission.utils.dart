
import 'package:permission_handler/permission_handler.dart';

class PermissionUtils {
  static void ensurePermissions() async {
    final status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
  }
}