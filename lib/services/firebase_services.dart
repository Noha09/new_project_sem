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
      // Obtén el ID del primer documento que coincida con los criterios
      return querySnapshot.docs.first.id;
    } else {
      return null; // No se encontró ningún usuario
    }
  } catch (e) {
    print('Error al autenticar usuario: $e');
    return null; // En caso de error, retorna null
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
    "id": 3,
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

Future<List> getPeticionesByUserId(String userId) async {
  List peticiones = [];
  CollectionReference collectionReferencePeticiones = db.collection('peticiones');

  QuerySnapshot queryPeticiones = await collectionReferencePeticiones
      .where('persona', isEqualTo: userId)
      .get();

  print('Documentos encontrados: ${queryPeticiones.docs.length}'); // Imprime la cantidad de documentos encontrados

  queryPeticiones.docs.forEach((documento) {
    print('Documento encontrado: ${documento.data()}'); // Muestra el contenido de cada documento
    peticiones.add(documento.data());
  });

  return peticiones;
}

Future<void> savePeticionies(String peticion, String persona) async {
  String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  await db.collection('peticiones').add({
    "peticion": peticion, 
    "persona": persona, 
    "fecha": formattedDate,
    "cumplida": false
  });
}