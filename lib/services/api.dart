import 'package:location_tracker/constants/var_type.dart';
import 'package:location_tracker/models/todo_model.dart';
import 'package:location_tracker/models/user_model/user_model.dart';

abstract class ApiService {
  FutureData<List<UserModel>?> getUsers();

  FutureData<List<TodoModel>> getTodos();
}
