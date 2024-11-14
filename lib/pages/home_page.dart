import 'package:flutter/material.dart';
import 'package:crudfluter/services/firebase_services.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  late TabController _tabController;
  bool isAdmin = false;

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

  Future<void> updateCumplidaStatus(String peticionId, bool status) async {
    await updatePeticionStatus(peticionId, status);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final userId = args['userId'] as String;
    final role = args['rol'] as String;

    isAdmin = role == 'admin';
    if (isAdmin) {
      _tabController = TabController(length: 3, vsync: this);
    }

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
          tabs: isAdmin
              ? const [
                  Tab(icon: Icon(Icons.pending_actions)),
                  Tab(icon: Icon(Icons.check_circle_outline)),
                  Tab(icon: Icon(Icons.person)),
                ]
              : const [
                  Tab(icon: Icon(Icons.list)),
                  Tab(icon: Icon(Icons.person)),
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
              children: isAdmin
                  ? [
                      FutureBuilder(
                        future: getPeticionesPorCumplida(false),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                              itemCount: snapshot.data?.length,
                              itemBuilder: (context, index) {
                                final peticionData = snapshot.data?[index]
                                    as Map<String, dynamic>;
                                final peticionId = peticionData['id'] as String;
                                final userId =
                                    peticionData['persona'] as String;
                                final peticion =
                                    peticionData['peticion'] as String;
                                final fechaString =
                                    peticionData['fecha'] as String;

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
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Fecha: $fechaFormateada',
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                IconButton(
                                                  icon: const Icon(
                                                      Icons.check_circle,
                                                      color: Colors.grey),
                                                  tooltip:
                                                      'Marcar como cumplida',
                                                  onPressed: () =>
                                                      updateCumplidaStatus(
                                                          peticionId, true),
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
                        future: getPeticionesPorCumplida(true),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                              itemCount: snapshot.data?.length,
                              itemBuilder: (context, index) {
                                final peticionData = snapshot.data?[index]
                                    as Map<String, dynamic>;
                                final userId =
                                    peticionData['persona'] as String;
                                final peticion =
                                    peticionData['peticion'] as String;
                                final fechaString =
                                    peticionData['fecha'] as String;

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
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Fecha: $fechaFormateada',
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                const Icon(Icons.check_circle,
                                                    color: Colors.green),
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
                      _buildPersonalTab(userId),
                    ]
                  : [
                      _buildAllRequestsTab(),
                      _buildPersonalTab(userId),
                    ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAllRequestsTab() {
    return FutureBuilder(
      future: getPeticiones(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (context, index) {
              final peticionData =
                  snapshot.data?[index] as Map<String, dynamic>;
              final userId = peticionData['persona'] as String;
              final peticion = peticionData['peticion'] as String;
              final cumplida = peticionData['cumplida'] as bool;
              final fechaString = peticionData['fecha'] as String;
              DateTime fecha;
              try {
                fecha = DateTime.parse(fechaString);
              } catch (e) {
                fecha = DateTime.now();
              }
              final fechaFormateada = DateFormat('dd/MM/yyyy').format(fecha);

              return FutureBuilder<String>(
                future: getUserNameById(userId),
                builder: (context, userSnapshot) {
                  final userName = userSnapshot.data ?? 'anónimo';
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Fecha: $fechaFormateada',
                                  style: const TextStyle(color: Colors.grey)),
                              Icon(cumplida ? Icons.check_circle : Icons.cancel,
                                  color: cumplida ? Colors.green : Colors.red),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(peticion,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 10),
                          Text('Solicitado por: $userName',
                              style: const TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _buildPersonalTab(String userId) {
    return FutureBuilder(
      future: getPeticionesByUserId(userId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (context, index) {
              final peticionData =
                  snapshot.data?[index] as Map<String, dynamic>;
              final peticion = peticionData['peticion'] as String;
              final cumplida = peticionData['cumplida'] as bool;
              final fechaString = peticionData['fecha'] as String;
              DateTime fecha;
              try {
                fecha = DateTime.parse(fechaString);
              } catch (e) {
                fecha = DateTime.now();
              }
              final fechaFormateada = DateFormat('dd/MM/yyyy').format(fecha);

              return Card(
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Fecha: $fechaFormateada',
                              style: const TextStyle(color: Colors.grey)),
                          Icon(cumplida ? Icons.check_circle : Icons.cancel,
                              color: cumplida ? Colors.green : Colors.red),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(peticion,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              );
            },
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
