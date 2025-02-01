import 'package:shared_preferences/shared_preferences.dart';
import 'package:location_tracker/models/todo_model.dart';

class TodoRepository {
  final SharedPreferences instance;

  TodoRepository(this.instance);

  Future<void> saveTodos(List<TodoModel> todos) async {
    List<String> todoJsonList = todos.map((todo) => todo.toJson()).toList();
    await instance.setStringList('todos', todoJsonList);
  }

  List<TodoModel> fetchTodos() {
    List<String>? todoJsonList = instance.getStringList('todos');
    if (todoJsonList != null) {
      return todoJsonList
          .map((todoJson) => TodoModel.fromJson(todoJson))
          .toList();
    }
    return [];
  }
}
