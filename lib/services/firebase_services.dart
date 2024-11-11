import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<bool> authenticateUser(String name, String password) async {
  try {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('people')
        .where('name', isEqualTo: name)
        .where('password', isEqualTo: password)
        .where('status', isEqualTo: 'active')
        .get();
      
    return querySnapshot.docs.isNotEmpty;
  } catch (e) {
    print('Error al autenticar usuario: $e');
    return false;
  }
}

Future<List> getPeople() async {
  List people = [];
  CollectionReference collectionReferencePeolpe = db.collection('people');
  QuerySnapshot queryPeople = await collectionReferencePeolpe.get();

  queryPeople.docs.forEach((documento) {
    people.add(documento.data());
  });

  return people;
}

Future<void> savePeople(String name, String password) async {
  await db.collection('people').add({
    "name": name, 
    "password": password, 
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

Future<void> savePeticionies(String peticion, String persona) async {
  String formattedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

  await db.collection('people').add({
    "peticion": peticion, 
    "persona": persona, 
    "fecha": formattedDate,
    "cumplida": false
  });
}