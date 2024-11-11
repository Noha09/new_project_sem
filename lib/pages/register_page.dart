import 'package:flutter/material.dart';
import 'package:crudfluter/services/firebase_services.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController nameController = TextEditingController(text: "");
  TextEditingController passwordController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0), // Aumentamos el padding para mayor margen
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Centra los elementos verticalmente
            crossAxisAlignment: CrossAxisAlignment.stretch, // Hace que el ancho ocupe toda la pantalla
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  hintText: 'Enter Name',
                ),
              ),
              const SizedBox(height: 20), // Espacio entre los campos
              TextField(
                controller: passwordController,
                obscureText: true, // Oculta el texto para el campo de contraseña
                decoration: const InputDecoration(
                  hintText: 'Enter Password',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  await savePeople(nameController.text, passwordController.text).then((_) {
                    Navigator.pushReplacementNamed(context, '/');
                  });
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
