import 'package:flutter/material.dart';
import '../models/diary_model.dart';
import '../services/api_services.dart';
import '../services/auth_service.dart';

class DiaryViewModel extends ChangeNotifier {
  late ApiService apiService;
  late AuthService authService;
  List<DiaryModel> diaries = [];
  bool isLoading = false;

  DiaryViewModel() {
    apiService = ApiService();
    authService = AuthService();
    fetchDiaries();
  }

  Future<void> fetchDiaries() async {
    isLoading = true;
    notifyListeners();

    final user = await authService.getUser();
    if (user != null) {
      try {
        diaries = await apiService.getDiaries(user.token);
      } catch (e) {
        print('Failed to load diaries: $e');
      }
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> addDiary(String title, String content) async {
    final user = await authService.getUser();
    if (user != null) {
      try {
        final diary = await apiService.createDiary(user.token, title, content);
        diaries.add(diary);
        notifyListeners();
      } catch (e) {
        print('Failed to create diary: $e');
      }
    }
  }
}
