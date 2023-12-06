import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pomodoroforest/firebase_options.dart';
import 'home.dart';
import 'login.dart';
import 'settings.dart';
import 'shop.dart';
import 'garden.dart';
import 'register.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
