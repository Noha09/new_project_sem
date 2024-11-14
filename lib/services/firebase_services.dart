import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<Map<String, dynamic>?> authenticateUser(String name, String password) async {
  try {
    final querySnapshot = await db
        .collection('people')
        .where('name', isEqualTo: name)
        .where('password', isEqualTo: password)
        .where('status', isEqualTo: 'active')
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      final userDoc = querySnapshot.docs.first;
      final userId = userDoc.id;
      final userRole = userDoc['rol'] ?? 'user';
      return {
        'id': userId,
        'rol': userRole,
      };
    } else {
      return null;
    }
  } catch (e) {
    print('Error al autenticar usuario: $e');
    return null;
  }
}

Future<String> getUserNameById(String userId) async {
  try {
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('people')
        .doc(userId)
        .get();

    if (userDoc.exists && userDoc.data() != null) {
      final userData = userDoc.data() as Map<String, dynamic>;
      return userData['name'] ?? 'anónimo';
    } else {
      return 'anónimo';
    }
  } catch (e) {
    print("Error al obtener el nombre del usuario: $e");
    return 'anónimo';
  }
}

Future<void> savePeople(String name, String password) async {
  await db.collection('people').add({
    "id": 3,
    "name": name, 
    "password": password, 
    "rol": "user",
    "status": "active"
  });
}

Future<List> getPeticiones() async {
  List peticiones = [];
  CollectionReference collectionReferencePeticiones = db.collection('peticiones');
  QuerySnapshot queryPeticiones = await collectionReferencePeticiones.get();

  queryPeticiones.docs.forEach((documento) {
    peticiones.add(documento.data());
  });

  return peticiones;
}

Future<List<Map<String, dynamic>>> getPeticionesPorCumplida(bool status) async {
  List<Map<String, dynamic>> peticiones = [];
  CollectionReference collectionReferencePeticiones = db.collection('peticiones');

  QuerySnapshot queryPeticiones = await collectionReferencePeticiones
      .where('cumplida', isEqualTo: status)
      .get();
  
  for (var documento in queryPeticiones.docs) {
    // Añade el ID del documento a los datos del mapa
    Map<String, dynamic> peticionData = documento.data() as Map<String, dynamic>;
    peticionData['id'] = documento.id; // Incluye el ID en el mapa
    peticiones.add(peticionData);
  }

  return peticiones;
}

Future<List> getPeticionesByUserId(String userId) async {
  List peticiones = [];
  CollectionReference collectionReferencePeticiones = db.collection('peticiones');

  QuerySnapshot queryPeticiones = await collectionReferencePeticiones
      .where('persona', isEqualTo: userId)
      .get();

  queryPeticiones.docs.forEach((documento) {
    peticiones.add(documento.data());
  });

  return peticiones;
}

Future<void> savePeticionies(String peticion, String userId) async {
  String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  await db.collection('peticiones').add({
    "peticion": peticion, 
    "persona": userId, 
    "fecha": formattedDate,
    "cumplida": false
  });
}

Future<void> updatePeticionStatus(String peticionId, bool status) async {
  await db.collection('peticiones').doc(peticionId).update({ "cumplida":status });
}