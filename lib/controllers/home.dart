import 'package:get/get.dart';
import 'package:location_tracker/constants/enums.dart';
import 'package:location_tracker/models/todo_model.dart';
import 'package:location_tracker/models/user_model/user_model.dart';
import 'package:location_tracker/services/api.dart';
import 'package:location_tracker/services/api_impl.dart';

class HomeController extends GetxController {
  HomeController() {
    init();
  }
  final ApiService _service = ApiServiceImpl();

  init() async {
    await requestTodos();
    await requestUsers();
  }

  late List<UserModel> userList;
  late List<TodoModel> todoList;
  late String errorMessage;
  RequestState _userState = RequestState.initial;
  RequestState _todoState = RequestState.initial;

  RequestState get userState => _userState;
  RequestState get todoState => _todoState;

  setUserRequestState(RequestState state) {
    _userState = state;
    update();
  }

  setTodoRequestState(RequestState state) {
    _todoState = state;
    update();
  }

  Future<void> requestUsers() async {
    setUserRequestState(RequestState.loading);
    final response = await _service.getUsers();
    response.fold(
      (l) {
        setUserRequestState(RequestState.error);
      },
      (r) {
        userList = [];
        userList = r!;
        setUserRequestState(RequestState.completed);
      },
    );
  }

  List<Map<String, dynamic>> getUserTodoList({required int userID}) {
    return todoList
        .where((todo) => todo.userId == userID)
        .map((todo) => todo.toMap())
        .toList();
  }

  Future<void> requestTodos() async {
    setTodoRequestState(RequestState.loading);
    final response = await _service.getTodos();
    response.fold(
      (l) {
        setTodoRequestState(RequestState.error);
      },
      (r) {
        todoList = [];
        todoList = r!;
        setTodoRequestState(RequestState.completed);
      },
    );
  }
}
