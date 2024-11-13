import 'package:crudfluter/pages/form_peticiones.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// Pages Imports
import 'package:crudfluter/pages/home_page.dart';
import 'package:crudfluter/pages/login_page.dart';
import 'package:crudfluter/pages/register_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Prueba CRUD',
      initialRoute: '/',
      routes: {
        '/home': (context) => const Home(),
        '/register': (context) => const Register(),
        '/': (context) => const Login(),
        '/create': (context) => const Peticiones()
      },
    );
  }
}
