import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<String?> authenticateUser(String name, String password) async {
  try {
    final querySnapshot = await db
        .collection('people')
        .where('name', isEqualTo: name)
        .where('password', isEqualTo: password)
        .where('status', isEqualTo: 'active')
        .get();
    
    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.first.id;
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
      return userData['name'] ?? 'anónimo'; // Retorna el nombre o "anónimo" si no está el campo
    } else {
      return 'anónimo'; // Si no existe el documento o está vacío, retorna "anónimo"
    }
  } catch (e) {
    print("Error al obtener el nombre del usuario: $e");
    return 'anónimo'; // En caso de error, también retorna "anónimo"
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
