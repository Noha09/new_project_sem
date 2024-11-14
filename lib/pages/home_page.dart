import 'package:flutter/material.dart';
import 'package:crudfluter/services/firebase_services.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> logout() async {
    Navigator.pushReplacementNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final userId = args['userId'] as String;
    final role = args['rol'] as String;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de peticiones'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: logout,
            tooltip: 'Cerrar sesión',
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Todas las Peticiones'),
            Tab(text: 'Mis Peticiones'),
          ],
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 40),
          const Text(
            'CONEXIÓN',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFFFFC107),
            ),
          ),
          const Text(
            'FITEC',
            style: TextStyle(
              fontSize: 16,
              letterSpacing: 2,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 20),

          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                FutureBuilder(
                  future: getPeticiones(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data?.length,
                        itemBuilder: (context, index) {
                          final peticionData = snapshot.data?[index];
                          final userId = peticionData['persona'];
                          final fechaString = peticionData['fecha'];
                          final peticion = peticionData['peticion'];
                          final cumplida = peticionData['cumplida'];

                          DateTime fecha;
                          try {
                            fecha = DateTime.parse(fechaString);
                          } catch (e) {
                            fecha = DateTime.now();
                            print("Error al convertir la fecha: $e");
                          }

                          final fechaFormateada =
                              DateFormat('dd/MM/yyyy').format(fecha);

                          return FutureBuilder<String>(
                            future: getUserNameById(userId),
                            builder: (context, userSnapshot) {
                              if (userSnapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }

                              final userName =
                                  userSnapshot.data ?? 'anónimo';

                              return Card(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 16.0),
                                elevation: 4,
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Fecha: $fechaFormateada',
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          Icon(
                                            cumplida
                                                ? Icons.check_circle
                                                : Icons.cancel,
                                            color: cumplida
                                                ? Colors.green
                                                : Colors.red,
                                            size: 20,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        peticion,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        'Solicitado por: $userName',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),

                FutureBuilder(
                  future: getPeticionesByUserId(userId),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data?.length,
                        itemBuilder: (context, index) {
                          final peticionData = snapshot.data?[index];
                          final fechaString = peticionData['fecha'];
                          final peticion = peticionData['peticion'];
                          final cumplida = peticionData['cumplida'];

                          DateTime fecha;
                          try {
                            fecha = DateTime.parse(fechaString);
                          } catch (e) {
                            fecha = DateTime.now();
                            print("Error al convertir la fecha: $e");
                          }

                          final fechaFormateada =
                              DateFormat('dd/MM/yyyy').format(fecha);

                          return Card(
                            margin: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 16.0),
                            elevation: 4,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Fecha: $fechaFormateada',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      Icon(
                                        cumplida
                                            ? Icons.check_circle
                                            : Icons.cancel,
                                        color: cumplida
                                            ? Colors.green
                                            : Colors.red,
                                        size: 20,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    peticion,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'Solicitado por: $userId',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
