import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kyty/Custom/PostCellView.dart';
import 'package:kyty/FirestoreObjects/FbPost.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  final List<FbPost> posts = [];

  @override
  void initState() {
    descargarPosts();
    super.initState();
  }

  void descargarPosts() async {
    CollectionReference<FbPost> reference = db
        .collection("Posts")
        .withConverter(fromFirestore: FbPost.fromFirestore,
        toFirestore: (FbPost usuario, _) => usuario.toFirestore());

    QuerySnapshot<FbPost> querySnap = await reference.get();
    for (int i = 0; i < querySnap.docs.length; i++) {
      setState(() {
        posts.add(querySnap.docs[i].data());
      });
    }
    //FbPost usuario = querySnap.data();
  }

  void onClickVolver(BuildContext context) {
    FirebaseAuth.instance.signOut();
    Navigator.of(context).popAndPushNamed('/loginview');
  }

  final List<String> postsOld = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];
  final List<double> fontSize = <double >[30, 15, 70];

  Widget? creadorDeItemLista(BuildContext context, int index) {
    return PostCellView(sText: posts[index].titulo,
      iColorCode: 0,
      dFontSize: 20);
  }

  Widget creadorDeSeparadorLista(BuildContext context, int index) {
    return Divider(color: Colors.red, thickness: 2,);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('KYTY'),),
      body: ListView.separated(
        padding: EdgeInsets.all(80),
        itemCount: posts.length,
        itemBuilder: creadorDeItemLista,
        separatorBuilder: creadorDeSeparadorLista,
      ),
    );
  }
}
