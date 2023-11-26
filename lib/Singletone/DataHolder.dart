import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../FirestoreObjects/FbPost.dart';
import '../FirestoreObjects/FbUsuario.dart';
import 'FirebaseAdmin.dart';
import 'GeolocAdmin.dart';
import 'HttpAdmin.dart';
import 'PlatformAdmin.dart';

class DataHolder {

  static final DataHolder _dataHolder = DataHolder._internal();

  String sNombre="Kyty DataHolder";
  late String sPostTitle;
  FbPost? selectedPost;
  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseAdmin fbAdmin = FirebaseAdmin();
  GeolocAdmin geolocAdmin = GeolocAdmin();
  late PlatformAdmin platformAdmin;
  HttpAdmin httpAdmin = HttpAdmin();
  late FbUsuario usuario;

  DataHolder._internal() {

  }

  factory DataHolder(){
    return _dataHolder;
  }

  void initDataHolder(){
    sPostTitle="Titulo de Post";
    //loadCachedFbPost();
  }

  void initPlatformAdmin(BuildContext context){
    platformAdmin = PlatformAdmin(context: context);
  }

  void crearPostEnFB(FbPost post) {
    CollectionReference<FbPost> postsRef = db.collection("Posts")
        .withConverter(
      fromFirestore: FbPost.fromFirestore,
      toFirestore: (FbPost post, _) => post.toFirestore(),
    );
    postsRef.add(post);
  }

  void saveSelectedPostInCache() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('fbpost_titulo', selectedPost!.titulo);
    prefs.setString('fbpost_cuerpo', selectedPost!.cuerpo);
    prefs.setString('fbpost_urlImage', selectedPost!.urlImage);
  }

  Future<FbUsuario?> loadFbUsuario() async{
    String uid=FirebaseAuth.instance.currentUser!.uid;
    print("UID DE DESCARGA loadFbUsuario------------->>>> ${uid}");
    DocumentReference<FbUsuario> ref=db.collection("Usuarios")
        .doc(uid)
        .withConverter(fromFirestore: FbUsuario.fromFirestore,
      toFirestore: (FbUsuario usuario, _) => usuario.toFirestore(),);


    DocumentSnapshot<FbUsuario> docSnap=await ref.get();
    print("docSnap DE DESCARGA loadFbUsuario------------->>>> ${docSnap.data()}");
    usuario=docSnap.data()!;
    return usuario;
  }

  Future<FbPost?> loadCachedFbPost() async {
    if(selectedPost!=null) return selectedPost;

    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? fbpostTitulo = prefs.getString('fbpost_titulo');
    fbpostTitulo??="";

    String? fbpostCuerpo = prefs.getString('fbpost_cuerpo');
    fbpostCuerpo??="";

    String? fbpostUrlImage = prefs.getString('fbpost_urlImage');
    fbpostUrlImage??="";

    print("SHARED PREFERENCES --> $fbpostTitulo");
    selectedPost = FbPost(titulo: fbpostTitulo, cuerpo: fbpostCuerpo, urlImage: fbpostUrlImage);

    return selectedPost;
  }

  void suscribeACambiosGPSUsuario(){
    geolocAdmin.registrarCambiosLoc(posicionDelMovilCambio);
  }

  void posicionDelMovilCambio(Position? position){
    usuario.geoloc=GeoPoint(position!.latitude, position.longitude);
    fbAdmin.actualizarPerfilUsuario(usuario);
  }
}