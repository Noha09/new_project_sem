import 'package:flutter/material.dart';

class IndexPage extends StatelessWidget {
  const IndexPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // "CONEXIÓN FITEC" header
              Column(
                children: const [
                  SizedBox(height: 40), // Espacio desde la parte superior
                  Text(
                    'CONEXIÓN',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFFC107), // Color amarillo
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
              const SizedBox(height: 20), // Espacio debajo del header
              
              // Card for "Versículo del Día"
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
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

              // Option cards
              _buildOptionCard(
                icon: Icons.format_list_bulleted,
                title: 'Lista de peticiones',
                description:
                    'Descubre las peticiones y agradecimientos de nuestra comunidad. Únete en oración y apoyo para quienes lo necesitan.',
                color: Colors.lightBlue,
              ),
              const SizedBox(height: 10),
              _buildOptionCard(
                icon: Icons.handshake,
                title: 'Nueva petición o agradecimiento',
                description:
                    'Un espacio para compartir tus peticiones y agradecimientos en comunidad.',
                color: Colors.lightBlue,
              ),

              const SizedBox(height: 20),

              // Bottom cards for "Testimonios" and "Mis favoritos"
            ],
          ),
        ),
      ),
    );
  }

  // Helper function for the option cards
  // Helper function for the option cards
// Helper function for the option cards
Widget _buildOptionCard({
  required IconData icon,
  required String title,
  required String description,
  required Color color,
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
          // Button with the arrow icon, no background or border
          TextButton(
            onPressed: () {
              // Acción del botón
            },
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              foregroundColor: Colors.lightBlue, // Color del ícono
            ),
            child: Icon(Icons.arrow_forward_ios, color: Colors.lightBlue),
          ),
        ],
      ),
    ),
  );
}
}
