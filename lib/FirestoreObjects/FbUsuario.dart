import 'package:cloud_firestore/cloud_firestore.dart';

class FbUsuario {
  final String nombre;
  final int edad;
  final double altura;
  final String colorPelo;

  FbUsuario({
      required this.nombre,
      required this.edad,
      required this.altura,
      required this.colorPelo,
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
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "nombre": nombre,
      "edad": edad,
      "altura": altura,
      "colorPelo": colorPelo,
    };
  }
}