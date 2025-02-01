import 'package:get/get.dart';
import 'package:location_tracker/routers/bindings.dart';
import 'package:location_tracker/routers/routers.dart';
import 'package:location_tracker/screens/home.dart';
import 'package:location_tracker/screens/map_overview.dart';
import 'package:location_tracker/screens/user_details.dart';

class AppRouter {
  static List<GetPage> routes = [
    GetPage(
      name: AppRoutes.mainScreen,
      page: () => const HomeScreen(),
    ),
    GetPage(
      name: AppRoutes.userDetailsScreen,
      page: () => const UserDetailsScreen(),
      binding: AppBinding.userDetails,
    ),
    GetPage(
      name: AppRoutes.mapsScreen,
      page: () => const MapOverviewScreen(),
      binding: AppBinding.mapBinder,
    )
  ];
}
