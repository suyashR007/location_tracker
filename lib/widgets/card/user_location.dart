import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location_tracker/constants/text_style.dart';
import 'package:location_tracker/controllers/global.dart';
import 'package:location_tracker/controllers/user_details.dart';
import 'package:location_tracker/services/my_locator.dart';
import 'package:location_tracker/services/my_permission.dart';
import 'package:location_tracker/widgets/button/primary.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class UserLocationViewCard extends StatelessWidget {
  const UserLocationViewCard({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<UserDetailsController>();
    return Card(
      elevation: 0,
      margin: EdgeInsets.symmetric(
        vertical: 1.h,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 1.h,
          horizontal: 2.w,
        ),
        child: StreamBuilder(
          stream: MyLocator.getLiveLocation(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final position = snapshot.data!;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Mine Location',
                    style: MyTextStyle.nameLabel.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                      text: 'Longitude: ',
                      style: MyTextStyle.labelText,
                      children: [
                        TextSpan(
                          text: position.longitude.toStringAsFixed(3),
                          style: MyTextStyle.valueText,
                        ),
                      ],
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                      text: 'Latitude: ',
                      style: MyTextStyle.labelText,
                      children: [
                        TextSpan(
                          text: position.latitude.toStringAsFixed(3),
                          style: MyTextStyle.valueText,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Text.rich(
                    TextSpan(
                      text:
                          'Distance from ${controller.model.name?.split(' ').first ?? 'user'}: ',
                      style: MyTextStyle.labelText,
                      children: [
                        TextSpan(
                          text: '${MyLocator.getDistance(
                            startLatitude: double.parse(
                                controller.model.address?.geo?.lat ?? '0'),
                            startLongitude: double.parse(
                                controller.model.address?.geo?.lng ?? '0'),
                            endLatitude: position.latitude,
                            endLongitude: position.longitude,
                          ).toStringAsFixed(2)} meters',
                          style: MyTextStyle.valueText,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
            if (snapshot.hasError) {
              final globalController = Get.find<GlobalController>();
              if (globalController.userLocationPermission == false) {
                return Column(
                  children: [
                    Text('Location Permission is denied'),
                    PrimaryButton(
                      onPressed: () =>
                          MyPermissionHandler.requestLocationPermission(),
                      child: Text('Location Permission'),
                    )
                  ],
                );
              }
              return Text('Error: ${snapshot.error}');
            }
            return Center(child: const CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
