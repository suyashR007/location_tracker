import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location_tracker/constants/text_style.dart';
import 'package:location_tracker/controllers/user_details.dart';
import 'package:location_tracker/widgets/card/todo_card.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class UserDetailsScreen extends StatelessWidget {
  const UserDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Details '),
      ),
      body: GetBuilder<UserDetailsController>(
        builder: (controller) => Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 4.w,
          ),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 1.h),
                    Text.rich(
                      TextSpan(
                        text: 'Name: ',
                        style: MyTextStyle.nameLabel,
                        children: [
                          TextSpan(
                            text: controller.model.name,
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
                            text: controller.model.email,
                            style: MyTextStyle.valueText,
                          ),
                        ],
                      ),
                    ),
                    Text.rich(
                      TextSpan(
                        text: 'Phone Number: ',
                        style: MyTextStyle.labelText,
                        children: [
                          TextSpan(
                            text: controller.model.phone,
                            style: MyTextStyle.valueText,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Text.rich(
                          TextSpan(
                            text: 'Longitude: ',
                            style: MyTextStyle.labelText,
                            children: [
                              TextSpan(
                                text: controller.model.address?.geo?.lat ?? '',
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
                                text: controller.model.address?.geo?.lng ?? '',
                                style: MyTextStyle.subText,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SliverList.builder(
                  itemCount: controller.userTodoList.length,
                  itemBuilder: (context, index) =>
                      TodoCard(model: controller.userTodoList[index]))
            ],
          ),
        ),
      ),
    );
  }
}
