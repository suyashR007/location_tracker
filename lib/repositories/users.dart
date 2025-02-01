import 'package:shared_preferences/shared_preferences.dart';
import 'package:location_tracker/models/user_model/user_model.dart';

class UsersRepository {
  final SharedPreferences instance;

  UsersRepository(this.instance);

  Future<void> saveUsers(List<UserModel> users) async {
    List<String> userJsonList = users.map((user) => user.toJson()).toList();
    await instance.setStringList('users', userJsonList);
  }

  List<UserModel> fetchUsers() {
    List<String>? userJsonList = instance.getStringList('users');
    if (userJsonList != null) {
      return userJsonList
          .map((userJson) => UserModel.fromJson(userJson))
          .toList();
    }
    return [];
  }
}
