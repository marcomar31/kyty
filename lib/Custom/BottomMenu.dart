import 'package:flutter/material.dart';


class BottomMenu extends StatelessWidget{

  Function(int indice)? onBotonesClicked;

  BottomMenu({Key? key,required this.onBotonesClicked
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //throw UnimplementedError();
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(onPressed: () => onBotonesClicked!(0), child: Icon(Icons.list, color: Colors.white,)),
          TextButton(onPressed: () => onBotonesClicked!(1), child: Icon(Icons.grid_view, color: Colors.white,)),
          TextButton(onPressed: () => onBotonesClicked!(2), child: Icon(Icons.exit_to_app, color: Colors.white,))
        ]
    );
  }
}