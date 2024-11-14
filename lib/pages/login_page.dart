import 'package:flutter/material.dart';
import 'package:crudfluter/services/firebase_services.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController nameController = TextEditingController(text: "");
  TextEditingController passwordController = TextEditingController(text: "");
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                hintText: 'Enter Name',
              ),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'Enter Password',
              ),
            ),
            const SizedBox(height: 20),
            Text(
              errorMessage,
              style: const TextStyle(color: Colors.red),
            ),
            ElevatedButton(
              onPressed: () async {
                String? userId = await authenticateUser(
                  nameController.text,
                  passwordController.text,
                );
                
                if (userId != null) {
                  Navigator.pushReplacementNamed(
                    context,
                    '/home',
                    arguments: userId,
                  );
                } else {
                  setState(() {
                    errorMessage = 'Usuario o contraseña incorrectos';
                  });
                }
              },
              child: const Text('Login'),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
              child: const Text('No tienes una cuenta? Regístrate aquí'),
            ),
          ],
        ),
      ),
    );
  }
}
