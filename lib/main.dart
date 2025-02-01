import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:location_tracker/routers/bindings.dart';
import 'package:location_tracker/routers/router.dart';
import 'package:location_tracker/routers/routers.dart';
import 'package:location_tracker/utils/helpers.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance().then(
    (value) => Helpers.setHelpers(prefs: value),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (p0, p1, p2) => GetMaterialApp(
        enableLog: true,
        initialBinding: AppBinding.globalBinder,
        initialRoute: AppRoutes.mainScreen,
        getPages: AppRouter.routes,
      ),
    );
  }
}
