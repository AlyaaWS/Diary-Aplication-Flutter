import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class AuthService {
  Future<void> saveUser(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', user.userId);
    await prefs.setString('name', user.name);
    await prefs.setString('token', user.token);
  }

  Future<UserModel?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    final name = prefs.getString('name');
    final token = prefs.getString('token');

    if (userId != null && name != null && token != null) {
      return UserModel(userId: userId, name: name, token: token);
    } else {
      return null;
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
