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
    _tabController = TabController(length: 3, vsync: this);
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
    if (isAdmin) {
      await updatePeticionStatus(peticionId, status);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final userId = args['userId'] as String;
    final role = args['rol'] as String;

    isAdmin = role == 'admin';

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
            Tab(icon: Icon(Icons.pending_actions), text: "Pendientes"),
            Tab(icon: Icon(Icons.check_circle_outline), text: "Completadas"),
            Tab(icon: Icon(Icons.person), text: "Personales"),
          ],
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildPendingRequestsTab(),
                _buildCompletedRequestsTab(),
                _buildPersonalTab(userId),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPendingRequestsTab() {
    return FutureBuilder(
      future: getPeticionesPorCumplida(false),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (context, index) {
              final peticionData =
                  snapshot.data?[index] as Map<String, dynamic>;
              final peticionId = peticionData['id'] as String;
              final userId = peticionData['persona'] as String;
              final peticion = peticionData['peticion'] as String;
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
                  return GestureDetector(
                    onTap: isAdmin
                        ? () => updateCumplidaStatus(peticionId, true)
                        : null,
                    child: _buildRequestCard(
                      peticion: peticion,
                      fechaFormateada: fechaFormateada,
                      userName: userName,
                      cumplida: false,
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

  Widget _buildCompletedRequestsTab() {
    return FutureBuilder(
      future: getPeticionesPorCumplida(true),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (context, index) {
              final peticionData =
                  snapshot.data?[index] as Map<String, dynamic>;
              final userId = peticionData['persona'] as String;
              final peticion = peticionData['peticion'] as String;
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
                  return _buildRequestCard(
                    peticion: peticion,
                    fechaFormateada: fechaFormateada,
                    userName: userName,
                    cumplida: true,
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

              return _buildRequestCard(
                peticion: peticion,
                fechaFormateada: fechaFormateada,
                userName: 'Tú',
                cumplida: cumplida,
              );
            },
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _buildRequestCard({
    required String peticion,
    required String fechaFormateada,
    required String userName,
    required bool cumplida,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      elevation: 4,
      color: Colors.grey[100],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        leading: CircleAvatar(
          backgroundColor: Colors.purple[200],
          child: Text(userName[0].toUpperCase(),
              style: const TextStyle(color: Colors.white)),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$userName',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              'Fecha: $fechaFormateada',
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            peticion,
            style: const TextStyle(fontSize: 14),
          ),
        ),
        trailing: Icon(
          cumplida ? Icons.check_circle : Icons.check_circle,
          color: cumplida ? Colors.green : Colors.grey,
          size: 28,
        ),
      ),
    );
  }
}
