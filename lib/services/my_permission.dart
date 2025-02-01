import 'package:permission_handler/permission_handler.dart';

class MyPermissionHandler {
  static Future<bool> requestLocationPermission() async {
    var status = await Permission.location.status;
    if (status.isGranted) {
      return true;
    } else if (status.isDenied) {
      var result = await Permission.location.request();
      return result.isGranted;
    } else if (status.isPermanentlyDenied) {
      // Open app settings to allow the user to enable permission
      await openAppSettings();
      return false;
    }
    return false;
  }
}
