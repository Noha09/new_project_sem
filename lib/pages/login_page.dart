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
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 1),
                  Text(
                    'CONEXIÓN',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFFC107),
                    ),
                  ),
                  Text(
                    'FITEC',
                    style: TextStyle(
                      fontSize: 16,
                      letterSpacing: 2,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 80),
                ],
              ),
              const SizedBox(height: 40),
              const Center(
                child: Text(
                  'Iniciar Sesión',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                '¡Bienvenido! Inicia sesión para acceder a tus peticiones y agradecimientos.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 40),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Usuario',
                  hintText: 'Ingresa tu nombre de usuario',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                  prefixIcon: const Icon(Icons.email_outlined),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  hintText: 'Ingresa tu contraseña',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                  prefixIcon: const Icon(Icons.lock_outline),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                errorMessage,
                style: const TextStyle(color: Colors.red, fontSize: 14),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    backgroundColor: const Color(0xFFFFC107),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 5,
                  ),
                  onPressed: () async {
                    final authResult = await authenticateUser(
                      nameController.text,
                      passwordController.text,
                    );

                    if (authResult != null) {
                      final userId = authResult['id'];
                      final userRole = authResult['rol'];

                      Navigator.pushReplacementNamed(
                        context,
                        '/index',
                        arguments: {'userId': userId, 'rol': userRole},
                      );
                    } else {
                      setState(() {
                        errorMessage = 'Usuario o contraseña incorrectos';
                      });
                    }
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: Text(
                  '¿No tienes una cuenta? Regístrate aquí',
                  style: TextStyle(color: Colors.blueAccent.withOpacity(0.5)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
