import 'package:flutter/material.dart';
import '../services/api_services.dart';
import '../services/auth_service.dart';
import '../models/user_model.dart';

class LoginViewModel extends ChangeNotifier {
  late ApiService apiService;
  late AuthService authService;

  LoginViewModel() {
    apiService = ApiService();
    authService = AuthService();
  }

  Future<void> login(BuildContext context, String email, String password) async {
    try {
      final response = await apiService.login(email, password);
      if (response['error'] == false) {
        final user = UserModel.fromJson(response['loginResult']);
        await authService.saveUser(user);
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        throw Exception(response['message']);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login failed: $e')));
    }
  }
}
