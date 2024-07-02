import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:moa/main.dart';
import 'package:moa/viewmodels/login_viewmodel.dart';
import 'package:moa/viewmodels/register_viewmodel.dart';
import 'package:moa/viewmodels/home_viewmodel.dart';

void main() {
  testWidgets('Login view test', (WidgetTester tester) async {
    // Build the widget tree
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => LoginViewModel()),
          ChangeNotifierProvider(create: (_) => RegisterViewModel()),
          ChangeNotifierProvider(create: (_) => HomeViewModel()),
        ],
        child: MaterialApp(
          home: Scaffold(
            body: MyApp(),
          ),
        ),
      ),
    );

    // Verify that the login view is displayed
    expect(find.text('Login'), findsOneWidget);

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
