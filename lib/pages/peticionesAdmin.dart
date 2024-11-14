import 'package:flutter/material.dart';
import 'package:crudfluter/services/firebase_services.dart'; // Asegúrate de tener la función para obtener peticiones

class PeticionesAdmin extends StatefulWidget {
  const PeticionesAdmin({super.key});

  @override
  State<PeticionesAdmin> createState() => _PeticionesAdminState();
}

class _PeticionesAdminState extends State<PeticionesAdmin> {
  late Future<List<Map<String, dynamic>>> peticiones; // Lista de peticiones

  @override
  void initState() {
    super.initState();
    // Obtiene las peticiones desde la base de datos
    //peticiones = fetchPeticiones(); Función para obtener las peticiones desde la base de datos
  }

  // Función ficticia para obtener las peticiones
  // Future<List<Map<String, dynamic>>> fetchPeticiones() async {
  //   // Aquí deberías hacer la llamada a Firebase o cualquier base de datos que estés usando
  //   // return await FirebaseServices.getPeticiones(); Asegúrate de implementar esto en tus servicios
  // }

  // Función para actualizar el estado de la petición (completada o no)
  // void marcarCompletada(String peticionId) async {
  //   await FirebaseServices.marcarComoCompletada(peticionId); // Actualiza el estado en Firebase
  //   setState(() {
  //     // Recarga las peticiones después de marcar como completada
  //     peticiones = fetchPeticiones();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Peticiones - Admin'),
        backgroundColor: const Color(0xFFFFC107), // Color amarillo
      ),
      body: Center(
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: peticiones,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }

            if (snapshot.hasError) {
              return const Text('Error al cargar las peticiones');
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Text('No hay peticiones pendientes');
            }

            List<Map<String, dynamic>> peticionesData = snapshot.data!;

            return ListView.builder(
              itemCount: peticionesData.length,
              itemBuilder: (context, index) {
                final peticion = peticionesData[index];
                final peticionId = peticion['id']; // ID de la petición
                final peticionText = peticion['texto']; // Texto de la petición
                final completada = peticion['completada']; // Estado de la petición

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: ListTile(
                    title: Text(peticionText),
                    subtitle: Text(completada ? 'Completada' : 'Pendiente'),
                    trailing: Checkbox(
                      value: completada,
                      onChanged: (bool? value) {
                        if (value != null && value) {
                          //marcarCompletada(peticionId); // Marcar como completada
                        }
                      },
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
