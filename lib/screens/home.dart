import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location_tracker/constants/enums.dart';
import 'package:location_tracker/controllers/home.dart';
import 'package:location_tracker/widgets/card/user_overview.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: GetBuilder<HomeController>(
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
