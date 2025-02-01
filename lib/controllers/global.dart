import 'package:get/get.dart';
import 'package:location_tracker/constants/enums.dart';
import 'package:location_tracker/models/todo_model.dart';
import 'package:location_tracker/models/user_model/user_model.dart';
import 'package:location_tracker/services/api/api.dart';
import 'package:location_tracker/services/api/api_impl.dart';
import 'package:location_tracker/services/my_locator.dart';

class GlobalController extends GetxController {
  GlobalController() {
    init();
  }
  final ApiService _service = ApiServiceImpl();
  bool userLocationPermission = false;

  init() async {
    await requestPermission();
    await fetchTodos();
    await fetchUsers();
  }

  Future<void> requestPermission() async {
    userLocationPermission = await MyLocator.handleLocationPermission();
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

  Future<void> fetchUsers() async {
    setUserRequestState(RequestState.loading);
    final response = await _service.getUsers();
    response.fold(
      (l) {
        print(l.toString());
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

  Future<void> fetchTodos() async {
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
