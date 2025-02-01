import 'dart:developer';

import 'package:get/get.dart';
import 'package:location_tracker/models/todo_model.dart';
import 'package:location_tracker/models/user_model/user_model.dart';

class UserDetailsController extends GetxController {
  final UserModel model;
  final List<TodoModel> userTodoList;

  UserDetailsController({
    required this.model,
    required this.userTodoList,
  }) {
    log('Elements in todo: ${userTodoList.length}');
  }

  static List<TodoModel> todoListConverter(List<dynamic> data) {
    return data
        .map((item) => TodoModel.fromMap(item as Map<String, dynamic>))
        .toList();
  }
}
