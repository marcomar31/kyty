import 'package:flutter/material.dart';

class Drawer_mobile extends StatelessWidget{

  Function(int indice)? onItemTap;

  Drawer_mobile({Key? key,required this.onItemTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.black,
            ),
            child: Text(
                style: TextStyle(color: Colors.white),
                'MENÚ'
            ),
          ),
          ListTile(
            selectedColor: Colors.blue,
            selected: true,
            title: const Text('HOME'),
            onTap: () {
              onItemTap!(0);
            },
          ),
          ListTile(
            title: const Text('VOLVER AL LOGIN'),
            onTap: () {
              onItemTap!(1);
            },
          ),
        ],
      ),
    );
  }

}