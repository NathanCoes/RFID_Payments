import 'package:flutter/material.dart';

class MenuApp extends StatefulWidget {
  const MenuApp ( { super.key } );

  @override
  State<StatefulWidget> createState() {
    return _MenuAppState();
  }

}

class _MenuAppState extends State<MenuApp> {

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RFID Payments'),
      ),
      body: const Column(
        children: [

        ],
      )
    );
  }
}