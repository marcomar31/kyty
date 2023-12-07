import 'package:cloud_firestore/cloud_firestore.dart';

class FbUsuario {
  final String nombre;
  final int edad;
  final double altura;
  final String colorPelo;
  GeoPoint geoloc;

  FbUsuario({
      required this.nombre,
      required this.edad,
      required this.altura,
      required this.colorPelo,
      required this.geoloc
  });

  factory FbUsuario.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return FbUsuario(
      nombre: data?['nombre'],
      edad: data?['edad'],
      altura: data?['altura'],
      colorPelo: data?['colorPelo'],
      geoloc:data?['geoloc'] != null ? data!['geoloc'] : const GeoPoint(0, 0)
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "nombre": nombre,
      "edad": edad,
      "altura": altura,
      "colorPelo": colorPelo,
      "geoloc": geoloc,
    };
  }
}