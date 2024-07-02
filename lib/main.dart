import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'views/login_view.dart';
import 'views/register_view.dart';
import 'views/home_view.dart';
import 'viewmodels/login_viewmodel.dart';
import 'viewmodels/register_viewmodel.dart';
import 'viewmodels/home_viewmodel.dart';
import 'viewmodels/diary_viewmodel.dart';
import 'services/api_services.dart';
import 'services/auth_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(create: (_) => RegisterViewModel()),
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
        ChangeNotifierProvider(create: (_) => DiaryViewModel()),
        Provider(create: (_) => ApiService()),
        Provider(create: (_) => AuthService()),
      ],
      child: MaterialApp(
        title: 'Flutter Diary App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => LoginView(),
          '/register': (context) => RegisterView(),
          '/home': (context) => HomeView(),
        },
      ),
    );
  }
}
