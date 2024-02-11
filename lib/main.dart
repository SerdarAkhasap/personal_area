import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:personal_area/firebase_options.dart';
import 'package:personal_area/screens/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );

  await _login(app);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Personal page',
      home: MainScreen(),
      themeMode: ThemeMode.light,
    );
  }
}

Future<void> _login(FirebaseApp app) async {
  final preferences = await SharedPreferences.getInstance();
  final auth = FirebaseAuth.instanceFor(app: app);
  final user = await auth.signInAnonymously();
  if (user.user != null) {
    preferences.setString('token', user.user!.uid);
  } else {
    preferences.remove('token');
  }
}

