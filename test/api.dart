// import 'package:flutter_test/flutter_test.dart';
// import 'package:location_tracker/models/todo_model.dart';
// import 'package:location_tracker/models/user_model/user_model.dart';
// import 'package:location_tracker/services/api.dart';
// import 'package:location_tracker/services/api_impl.dart';
// import 'package:location_tracker/utils/helpers.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// void main() {
//   setUpAll(() async {
//     SharedPreferences.setMockInitialValues({});
//     final prefs = await SharedPreferences.getInstance();
//     Helpers.setHelpers(prefs: prefs);
//   });

//   group('API Service Tests', () {
//     late ApiService apiService;

//     setUp(() {
//       apiService = ApiServiceImpl();
//     });

//     group('Todo Endpoints', () {
//       test('getTodos should return list of todos', () async {
//         final response = await apiService.getTodos();

//         response.fold(
//           (error) => fail('API call failed: ${error.toString()}'),
//           (success) {
//             expect(success, isNotNull);
//             expect(success?['data'], isA<List<TodoModel>>());

//             final todos = success?['data'] as List<TodoModel>;
//             if (todos.isNotEmpty) {
//               final todo = todos.first;

//               // Verify todo structure
//               expect(todo.id, isNotNull);
//               expect(todo.userId, isNotNull);
//               expect(todo.title, isA<String>());
//               expect(todo.completed, isA<bool>());

//               // Log for manual verification
//               print('Sample Todo: ${todo.toString()}');
//             }
//           },
//         );
//       });

//       // Add more todo-related tests here
//     });

//     group('User Endpoints', () {
//       test('getUsers should return list of users', () async {
//         final response = await apiService.getUsers();

//         response.fold(
//           (error) => fail('API call failed: ${error.toString()}'),
//           (success) {
//             expect(success, isNotNull);
//             expect(success?['data'], isA<List<UserModel>>());

//             final users = success?['data'] as List<UserModel>;
//             if (users.isNotEmpty) {
//               final user = users.first;

//               // Verify user structure
//               expect(user.id, isNotNull);
//               expect(user.name, isA<String>());
//               expect(user.email, isA<String>());
//               expect(user.address, isNotNull);
//               expect(user.phone, isA<String>());
//               expect(user.website, isA<String>());
//               expect(user.company, isNotNull);

//               print('Sample User: ${user.toString()}');
//             }
//           },
//         );
//       });
//     });
//   });
// }
