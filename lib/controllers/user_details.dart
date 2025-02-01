import 'dart:developer';

import 'package:get/get.dart';
import 'package:location_tracker/models/todo_model.dart';
import 'package:location_tracker/models/user_model/user_model.dart';

class UserDetailsController extends GetxController {
  final UserModel model;
  final List<TodoModel> userTodoList;
  String currentFilter = 'All';

  UserDetailsController({
    required this.model,
    required this.userTodoList,
  }) {
    log('Elements in todo: ${userTodoList.length}');
  }

  List<TodoModel> get filteredTodoList {
    switch (currentFilter) {
      case 'Completed':
        return userTodoList.where((todo) => todo.completed == true).toList();
      case 'Not Completed':
        return userTodoList.where((todo) => todo.completed == false).toList();
      default:
        return userTodoList;
    }
  }

  void setFilter(String filter) {
    currentFilter = filter;
    update(); // Notify listeners to rebuild the UI
  }

  void sortTodos() {
    userTodoList.sort((a, b) => (a.title ?? '').compareTo(b.title ?? ''));
    update(); // Notify listeners to rebuild the UI
  }

  static List<TodoModel> todoListConverter(List<dynamic> data) {
    return data
        .map((item) => TodoModel.fromMap(item as Map<String, dynamic>))
        .toList();
  }
}
