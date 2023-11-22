import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kyty/Singletone/GeolocAdmin.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../FirestoreObjects/FbPost.dart';
import 'FirebaseAdmin.dart';
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
  //HttpAdmin httpAdmin = HttpAdmin();

  DataHolder._internal() {
    //sPostTitle="Titulo de Post";
    //loadCachedFbPost();
  }

  factory DataHolder(){
    return _dataHolder;
  }

  void initDataHolder(){
    sPostTitle="Titulo de Post";
    //loadCachedFbPost();
  }

  void initPlatformAdmin(BuildContext context){
    platformAdmin=PlatformAdmin(context: context);
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

  Future<FbPost?> loadCachedFbPost() async {
    if(selectedPost!=null) return selectedPost;

    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? fbpostTitulo = prefs.getString('fbpost_titulo');
    fbpostTitulo??="";

    String? fbpostCuerpo = prefs.getString('fbpost_cuerpo');
    fbpostCuerpo??="";

    print("SHARED PREFERENCES --> $fbpostTitulo");
    selectedPost = FbPost(titulo: fbpostTitulo, cuerpo: fbpostCuerpo, urlImage: '');

    return selectedPost;
  }
}