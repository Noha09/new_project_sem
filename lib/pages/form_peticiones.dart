import 'package:flutter/material.dart';
import 'package:crudfluter/services/firebase_services.dart';

class Peticiones extends StatefulWidget {
  const Peticiones({super.key});

  @override
  State<Peticiones> createState() => _PeticionesState();
}

class _PeticionesState extends State<Peticiones> {
  TextEditingController peticionController = TextEditingController(text: "");
  bool isAnonymous = false; // Variable para verificar si es anónimo

  @override
  Widget build(BuildContext context) {
    final userId = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(title: const Text('Formulario de peticiones')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Encabezado de Conexión FITEC
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  SizedBox(height: 5),
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
                  SizedBox(height: 10),
                ],
              ),
              
              // Título y mensaje
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  SizedBox(height: 40),
                  Text(
                    'Peticiones',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Un espacio para compartir tus peticiones y agradecimientos en comunidad.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  SizedBox(height: 40),
                ],
              ),

              // Campo de texto para la petición
              TextField(
                controller: peticionController,
                decoration: InputDecoration(
                  labelText: 'Ingresa tu petición o agradecimiento',
                  hintText: 'Escribe tu petición aquí',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              const SizedBox(height: 20),

              // Switch para elegir entre público o anónimo
              SwitchListTile(
                title: const Text("Enviar como anónimo"),
                value: isAnonymous,
                onChanged: (bool value) {
                  setState(() {
                    isAnonymous = value;
                  });
                },
              ),
              const SizedBox(height: 20),

              // Botón para guardar la petición
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
                    final idToSend = isAnonymous ? "anónimo" : userId;
                    await savePeticionies(peticionController.text, idToSend)
                        .then((_) {
                      Navigator.pushReplacementNamed(context, '/home',
                          arguments: userId);
                    });
                  },
                  child: const Text(
                    'Guardar Petición',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
