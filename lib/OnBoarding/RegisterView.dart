import 'package:flutter/material.dart';

class RegisterView extends StatelessWidget {

  late BuildContext _context;

  void onCLickCancelar() {
    Navigator.of(_context).popAndPushNamed('/loginview');
  }

  void onClickAceptarRegister() {

  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    _context = context;
    Column columna = new Column(children: [
      //Text("LOGIN", style: TextStyle(fontSize: 25),),
      Padding(padding: EdgeInsets.symmetric(horizontal: 50, vertical: 16),
        child: TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Input User',
          ),
        ),
      ),
      Padding(padding: EdgeInsets.symmetric(horizontal: 50, vertical: 0),
        child: TextFormField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Input Password',
          ),
          obscureText: true,
        ),
      ),
      Padding(padding: EdgeInsets.symmetric(horizontal: 50, vertical: 16),
        child: TextFormField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Pasa id manco',
          ),
          obscureText: true,
        ),
      ),

      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Padding(padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20), child:
        TextButton(onPressed: onClickAceptarRegister, child: Text("ACEPTAR")),
        ),

        Padding(padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20), child:
        TextButton(onPressed: onCLickCancelar, child: Text("CANCELAR")),
        ),
      ],),
    ]);

    AppBar appBar = AppBar(
      title: const Text("REGISTREISION"),
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