import 'package:flutter/material.dart';

class TestimoniosPage extends StatelessWidget {
  final List<Map<String, String>> testimonios = [
    {
      'usuario': 'Ana López',
      'testimonio': 'La oración me ha dado paz y claridad en los momentos difíciles.',
      'fecha': '10 de Noviembre, 2024'
    },
    {
      'usuario': 'Carlos Pérez',
      'testimonio': 'Gracias a la comunidad por el apoyo y las palabras de aliento.',
      'fecha': '8 de Noviembre, 2024'
    },
    {
      'usuario': 'María Sánchez',
      'testimonio': 'He encontrado inspiración y esperanza al compartir mis experiencias.',
      'fecha': '6 de Noviembre, 2024'
    },
  ];

  TestimoniosPage({super.key});

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text(""),
    ),
    body: ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        // Aquí estarían los cards de testimonios
        _buildTestimonioCard(
          usuario: "Ana López",
          testimonio: "La oración me ha dado paz y claridad en los momentos difíciles.",
          fecha: "10 de Noviembre, 2024",
        ),
        _buildTestimonioCard(
          usuario: "Carlos Pérez",
          testimonio: "Gracias a la comunidad por el apoyo y las palabras de aliento.",
          fecha: "8 de Noviembre, 2024",
        ),_buildTestimonioCard(
          usuario: "María Sánchez",
          testimonio: "He encontrado inspiración y esperanza al compartir mis experiencias.",
          fecha: "6 de Noviembre, 2024",
        ),
        // Más cards...
      ],
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () {
        _mostrarFormularioTestimonio(context);
      },
      backgroundColor: Colors.lightBlue,
      child: const Icon(Icons.add),
    ),
  );
}

void _mostrarFormularioTestimonio(BuildContext context) {
  final TextEditingController usuarioController = TextEditingController();
  final TextEditingController testimonioController = TextEditingController();
  bool isAnonymous = false;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: const Text("Nuevo Testimonio"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: usuarioController,
              decoration: InputDecoration(
                labelText: "Nombre del usuario",
                hintText: "Ingresa tu nombre",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: testimonioController,
              maxLines: 4,
              decoration: InputDecoration(
                labelText: "Testimonio",
                hintText: "Escribe tu testimonio aquí",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
        actions: [
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
              onPressed: () {
                final String usuario = usuarioController.text;
                final String testimonio = testimonioController.text;
                
                // Lógica para guardar el testimonio
                print("Usuario: $usuario, Testimonio: $testimonio");

                Navigator.of(context).pop();
              },
              child: const Text(
                "Guardar Testimonio",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}

  Widget _buildTestimonioCard({
    required String usuario,
    required String testimonio,
    required String fecha,
  }) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.lightBlue[100],
                  child: Text(
                    usuario[0],
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      usuario,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      fecha,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              testimonio,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
