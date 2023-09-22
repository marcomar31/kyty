import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {

  late BuildContext _context;

  void onClickSumar() {

  }

  void onClickVolver() {
    Navigator.of(_context).popAndPushNamed('/loginview');
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    _context = context;
    Column columna = new Column(children: [
      //Text("LOGIN", style: TextStyle(fontSize: 25),),
      Padding(padding: EdgeInsets.symmetric(horizontal: 50, vertical: 16),
        child: Text('Bienvenido!!!',
          style: TextStyle(fontSize: 20),
        ),
      ),

      Padding(padding: EdgeInsets.symmetric(horizontal: 50, vertical: 16),
        child: Text('Numerin',
          style: TextStyle(fontSize: 20),
        ),
      ),

      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Padding(padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20), child:
        TextButton(onPressed: onClickSumar, child: Text("SUMAR")),
        ),

        Padding(padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20), child:
        TextButton(onPressed: onClickVolver, child: Text("VOLVER")),
        ),
      ],),

    ]);

    AppBar appBar = AppBar(
      title: const Text("HOME"),
      centerTitle: true,
      shadowColor: Colors.blue,
      backgroundColor: Colors.greenAccent.withOpacity(0.4),
      automaticallyImplyLeading: false,
    );

    Scaffold scaffold = Scaffold(body: columna,
      backgroundColor: Colors.greenAccent,
      appBar: appBar,);

    return scaffold;
  }

}