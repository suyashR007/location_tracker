import 'package:get/get.dart';
import 'package:location_tracker/controllers/home.dart';
import 'package:location_tracker/controllers/user_details.dart';
import 'package:location_tracker/models/user_model/user_model.dart';

class AppBinding {
  static BindingsBuilder homeBinder = BindingsBuilder(
    () => Get.lazyPut(() => HomeController()),
  );

  static BindingsBuilder userDetails = BindingsBuilder(
    () => Get.lazyPut(
      () => UserDetailsController(
          model: UserModel.fromMap(Get.arguments['userModel']),
          userTodoList:
              UserDetailsController.todoListConverter(Get.arguments['todos'])),
    ),
  );
}
