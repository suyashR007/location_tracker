import 'package:location_tracker/repositories/todos.dart';
import 'package:location_tracker/repositories/users.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyPrefs {
  static SharedPreferences? _prefs;

  static setPrefs({required SharedPreferences prefs}) {
    _prefs = prefs;
  }

  static TodoRepository get todoRepo => TodoRepository(_prefs!);
  static UsersRepository get userRepo => UsersRepository(_prefs!);
}
