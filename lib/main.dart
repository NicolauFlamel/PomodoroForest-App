import 'package:flutter/material.dart';
import 'home.dart';
import 'login.dart';
import 'settings.dart';
import 'shop.dart';
import 'garden.dart';
import 'register.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/register': (context) => RegistrationPage(),
        '/home': (context) => PomodoroPage(),
        '/home/settings': (context) => SettingsPage(),
        '/home/shop': (context) => ShopPage(),
        '/home/garden': (context) => GardenScreen(),
      },
    );
  }
}
