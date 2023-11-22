import 'package:cloud_firestore/cloud_firestore.dart';

class FbPost {
  final String titulo;
  final String cuerpo;
  final String urlImage;

  FbPost({
    required this.titulo,
    required this.cuerpo,
    required this.urlImage,
  });

  factory FbPost.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return FbPost(
      titulo: data?['titulo'],
      cuerpo: data?['cuerpo'],
      urlImage: data?['imagen'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (titulo != null) "titulo": titulo,
      if (cuerpo != null) "cuerpo": cuerpo,
      if (urlImage != null) "imagen": urlImage,
    };
  }
}