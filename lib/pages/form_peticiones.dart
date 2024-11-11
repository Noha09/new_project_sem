import 'package:flutter/material.dart';
import 'package:crudfluter/services/firebase_services.dart';

class Peticiones extends StatefulWidget {
  const Peticiones({super.key});

  @override
  State<Peticiones> createState() => _PeticionesState();
}

class _PeticionesState extends State<Peticiones> {
  TextEditingController peticionController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Peticiones'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0), // Aumentamos el padding para mayor margen
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Centra los elementos verticalmente
            crossAxisAlignment: CrossAxisAlignment.stretch, // Hace que el ancho ocupe toda la pantalla
            children: [
              TextField(
                controller: peticionController,
                decoration: const InputDecoration(
                  hintText: 'Enter Name',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  await savePeticionies(peticionController.text, '').then((_) {
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
