
import 'package:permission_handler/permission_handler.dart';

class PermissionUtils {
  static void ensurePermissions() async {
    print("ENSURING PERMISSIONS");
    final isGranted = await Permission.storage.request().isGranted;
    if ( ! isGranted ) {
      await Permission.storage.request();
    }
    print(Permission.storage.status);
  }
}