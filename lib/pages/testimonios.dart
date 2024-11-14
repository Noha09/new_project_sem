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
        title: const Text(''),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Testimonios',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFFC107),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Comparte cómo la oración ha tocado tu vida y encuentra inspiración en las experiencias de otros.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: testimonios.length,
                itemBuilder: (context, index) {
                  final testimonio = testimonios[index];
                  return _buildTestimonioCard(
                    usuario: testimonio['usuario']!,
                    testimonio: testimonio['testimonio']!,
                    fecha: testimonio['fecha']!,
                  );
                },
              ),
            ),
          ],
        ),
      ),
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
