import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kyty/Singletone/GeolocAdmin.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../FirestoreObjects/FbPost.dart';
import 'FirebaseAdmin.dart';

class DataHolder {

  static final DataHolder _dataHolder = new DataHolder._internal();

  String sNombre="Kyty DataHolder";
  late String sPostTitle;
  FbPost? selectedPost;
  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseAdmin fbAdmin = FirebaseAdmin();
  GeolocAdmin geolocAdmin = GeolocAdmin();

  DataHolder._internal() {
    //sPostTitle="Titulo de Post";
    loadCachedFbPost();
  }

  factory DataHolder(){
    return _dataHolder;
  }

  void initDataHolder(){
    sPostTitle="Titulo de Post";
    loadCachedFbPost();
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
  }

  Future<FbPost?> loadCachedFbPost() async {
    if(selectedPost!=null) return selectedPost;

    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? fbpost_titulo = prefs.getString('fbpost_titulo');
    fbpost_titulo??="";

    String? fbpost_cuerpo = prefs.getString('fbpost_cuerpo');
    fbpost_cuerpo??="";

    print("SHARED PREFERENCES --> "+fbpost_titulo);
    selectedPost = FbPost(titulo: fbpost_titulo, cuerpo: fbpost_cuerpo);

    return selectedPost;
  }
}