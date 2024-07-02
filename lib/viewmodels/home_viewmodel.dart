import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class HomeViewModel extends ChangeNotifier {
  late AuthService authService;

  HomeViewModel() {
    authService = AuthService();
  }

  Future<void> logout(BuildContext context) async {
    await authService.logout();
    Navigator.pushReplacementNamed(context, '/');
  }
}
