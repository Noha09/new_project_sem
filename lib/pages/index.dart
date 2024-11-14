import 'package:flutter/material.dart';

class IndexPage extends StatelessWidget {
  const IndexPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final userId = args['userId'] as String;
    final role = args['rol'] as String;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Column(
                children: [
                  SizedBox(height: 40),
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
                ],
              ),
              const SizedBox(height: 20),

              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 2,
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.sunny, color: Colors.black),
                          SizedBox(width: 8),
                          Text(
                            'Versículo del Día',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Jeremías 29:11\n\n'
                        '“Porque yo sé los pensamientos que tengo acerca de vosotros, dice Jehová, '
                        'pensamientos de paz, y no de mal, para daros el fin que esperáis”.',
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Bienvenido!',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              _buildOptionCard(
                icon: Icons.format_list_bulleted,
                title: 'Lista de peticiones',
                description:
                    'Descubre las peticiones y agradecimientos de nuestra comunidad. Únete en oración y apoyo para quienes lo necesitan.',
                color: Colors.lightBlue,
                onTap: () {
                  Navigator.pushNamed(context, '/home', arguments: {'userId': userId, 'rol': role});
                },
              ),
              const SizedBox(height: 10),
              _buildOptionCard(
                icon: Icons.handshake,
                title: 'Nueva petición o agradecimiento',
                description:
                    'Un espacio para compartir tus peticiones y agradecimientos en comunidad.',
                color: Colors.lightBlue,
                onTap: () {
                  Navigator.pushNamed(context, '/create', arguments: userId);
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionCard({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
    required VoidCallback onTap
  }) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon, color: Colors.black, size: 30),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: const TextStyle(color: Colors.black54),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: onTap, 
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                foregroundColor: Colors.lightBlue,
              ),
              child: const Icon(Icons.arrow_forward_ios, color: Colors.lightBlue),
            ),
          ],
        ),
      ),
    );
  }
}
