import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location_tracker/constants/enums.dart';
import 'package:location_tracker/controllers/global.dart';
import 'package:location_tracker/routers/routers.dart';
import 'package:location_tracker/widgets/card/user_overview.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final globalController = Get.find<GlobalController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Location Tracker ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Map Overview'),
              onTap: () => Get.toNamed(AppRoutes.mapsScreen),
            ),
            ListTile(
              title: Text('Sync Data'),
              onTap: () => globalController.init(),
            ),
          ],
        ),
      ),
      body: GetBuilder<GlobalController>(
        builder: (controller) => switch (controller.userState) {
          RequestState.initial =>
            Center(child: CircularProgressIndicator.adaptive()),
          RequestState.loading =>
            Center(child: CircularProgressIndicator.adaptive()),
          RequestState.error => Center(child: Text('Something went Wrong')),
          RequestState.completed => SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Column(
                children: controller.userList
                    .map((e) => UserOverviewCard(model: e))
                    .toList(),
              ),
            )
        },
      ),
    );
  }
}
