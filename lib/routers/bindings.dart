import 'package:get/get.dart';
import 'package:location_tracker/controllers/global.dart';
import 'package:location_tracker/controllers/map.dart';
import 'package:location_tracker/controllers/user_details.dart';
import 'package:location_tracker/models/user_model/user_model.dart';

class AppBinding {
  static BindingsBuilder globalBinder = BindingsBuilder(
    () => Get.lazyPut(
      () => GlobalController(),
      fenix: true,
    ),
  );

  static BindingsBuilder userDetails = BindingsBuilder(
    () => Get.lazyPut(
      () => UserDetailsController(
          model: UserModel.fromMap(Get.arguments['userModel']),
          userTodoList:
              UserDetailsController.todoListConverter(Get.arguments['todos'])),
    ),
  );

  static BindingsBuilder mapBinder = BindingsBuilder(
    () => Get.lazyPut(
      () => MapScreenController(),
      fenix: true,
    ),
  );
}
