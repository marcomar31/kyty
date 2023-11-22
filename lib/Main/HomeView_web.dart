import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kyty/Custom/Drawer_mobile.dart';
import 'package:kyty/Custom/PostListView.dart';
import 'package:kyty/Custom/PostGridView.dart';
import 'package:kyty/FirestoreObjects/FbPost.dart';
import 'package:kyty/Singletone/DataHolder.dart';

import '../Custom/BottomMenu.dart';
import '../OnBoarding/LoginView_web.dart';

class HomeView_web extends StatefulWidget {
  @override
  _HomeView_webState createState() => _HomeView_webState();
}

class _HomeView_webState extends State<HomeView_web> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  final List<FbPost> posts = [];
  bool blIsList = false;
  late BottomMenu bottomMenu;

  Widget? creadorDeItemLista(BuildContext context, int index) {
    return PostListView(sText: posts[index].titulo,
        dFontSize: 20, iPosicion: index, onItemListClickedFun: onClickItemList,);
  }

  Widget creadorDeSeparadorLista(BuildContext context, int index) {
    return Column(
      children: [
        Divider(color: Color.fromRGBO(37, 77, 152, 1.0), thickness: 2,),
      ],
    );
  }

  Widget? creadorDeItemMatriz(BuildContext context, int index){
    return PostGridView(post: posts, iPosicion: index, onItemListaClickedFunction: onClickItemList,);
  }

  Widget? celdasOLista(bool isList) {
    if (isList) {
      return ListView.separated(
        padding: EdgeInsets.all(8),
        itemCount: posts.length,
        itemBuilder: creadorDeItemLista,
        separatorBuilder: creadorDeSeparadorLista,
      );
    } else {
      return creadorDeItemMatriz(context, posts.length);
    }
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

  void onClickItemList(int index) {
    DataHolder().selectedPost = posts[index];
    DataHolder().saveSelectedPostInCache();
    Navigator.of(context).pushNamed("/postview");
  }

  void onClickBottonMenu(int indice) {
    // TODO: implement onBottonMenuPressed
    setState(() {
      if(indice == 0){
        blIsList = true;
      }
      else if(indice == 1){
        blIsList = false;
      }
      else if(indice == 2){
        exit(0);
      }
    });
  }

  //Mostrar menú vertical
  void fHomeViewDrawerOnTap(int indice){
    if (indice == 0) {

    } else if(indice==1){
      FirebaseAuth.instance.signOut();
      Navigator.of(context).pushAndRemoveUntil (
        MaterialPageRoute (builder: (BuildContext context) =>  LoginView_web()),
        ModalRoute.withName('/loginview'),
      );
    } else if(indice==2){
      exit(0);
    }
  }

  @override
  void initState() {
    descargarPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar:
      AppBar(title: Text('KYTY'), backgroundColor: Color.fromRGBO(37, 77, 152, 1.0)), body:
      Padding(padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16), child:
        Center(child: celdasOLista(blIsList)),
      ),
      bottomNavigationBar: BottomMenu(onBotonesClicked: this.onClickBottonMenu),
      drawer: Drawer_mobile(onItemTap: fHomeViewDrawerOnTap),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("/postcreateview");
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      backgroundColor: Color.fromRGBO(49, 101, 203, 1.0),
    );
  }
}
