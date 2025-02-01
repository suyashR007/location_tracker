import 'package:get/get.dart';
import 'package:location_tracker/routers/bindings.dart';
import 'package:location_tracker/routers/routers.dart';
import 'package:location_tracker/screens/home.dart';
import 'package:location_tracker/screens/user_details.dart';

class AppRouter {
  static List<GetPage> routes = [
    GetPage(
      name: AppRoutes.mainScreen,
      page: () => const HomeScreen(),
      binding: AppBinding.homeBinder,
    ),
    GetPage(
      name: AppRoutes.userDetailsScreen,
      page: () => const UserDetailsScreen(),
      binding: AppBinding.userDetails,
    ),
  ];
}
