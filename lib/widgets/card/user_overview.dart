import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location_tracker/constants/text_style.dart';
import 'package:location_tracker/controllers/global.dart';
import 'package:location_tracker/models/user_model/user_model.dart';
import 'package:location_tracker/routers/routers.dart';
import 'package:location_tracker/widgets/button/primary.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class UserOverviewCard extends StatelessWidget {
  final UserModel model;
  const UserOverviewCard({
    required this.model,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<GlobalController>();
    return Card(
      margin: EdgeInsets.symmetric(vertical: 1.h),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 0.5.h,
          horizontal: 2.w,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 0.5.h,
          children: [
            Text.rich(
              TextSpan(
                text: 'Name: ',
                style: MyTextStyle.nameLabel,
                children: [
                  TextSpan(
                    text: model.name,
                    style: MyTextStyle.nameValue,
                  ),
                ],
              ),
            ),
            Text.rich(
              TextSpan(
                text: 'Email: ',
                style: MyTextStyle.labelText,
                children: [
                  TextSpan(
                    text: model.email,
                    style: MyTextStyle.valueText,
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Text.rich(
                  TextSpan(
                    text: 'longitude: ',
                    style: MyTextStyle.labelText,
                    children: [
                      TextSpan(
                        text: model.address?.geo?.lat ?? '',
                        style: MyTextStyle.valueText,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 6.w),
                Text.rich(
                  TextSpan(
                    text: 'Latitude: ',
                    style: MyTextStyle.labelText,
                    children: [
                      TextSpan(
                        text: model.address?.geo?.lng ?? '',
                        style: MyTextStyle.subText,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(),
            PrimaryButton(
              onPressed: () => Get.toNamed(
                AppRoutes.userDetailsScreen,
                arguments: {
                  'userModel': model.toMap(),
                  'todos': homeController.getUserTodoList(userID: model.id!)
                },
              ),
              child: Text(
                'View Details',
                style: MyTextStyle.buttonText,
              ),
            ),
            SizedBox(height: 0.5.h)
          ],
        ),
      ),
    );
  }
}
