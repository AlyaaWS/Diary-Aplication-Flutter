import 'package:flutter/material.dart';
import '../services/api_services.dart';
import '../services/auth_service.dart';
import '../models/user_model.dart';

class RegisterViewModel extends ChangeNotifier {
  late ApiService apiService;
  late AuthService authService;

  RegisterViewModel() {
    apiService = ApiService();
    authService = AuthService();
  }

  Future<void> register(BuildContext context, String name, String email, String password) async {
    try {
      final response = await apiService.register(name, email, password);
      if (response['error'] == false) {
        final user = UserModel.fromJson(response);
        await authService.saveUser(user);
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        throw Exception(response['message']);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Register failed: $e')));
    }
  }
}
