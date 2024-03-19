import 'package:cfid_payments/screens/menu.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const RfidApp());
}

class RfidApp extends StatefulWidget {
  const RfidApp ( {super.key} );
  
  @override
  State<RfidApp> createState(){
    return _RfidAppState();
  }
}

class _RfidAppState extends State<RfidApp> {
  final theme = ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Color.fromARGB(255, 35, 210, 223),
      ),
      textTheme: GoogleFonts.manjariTextTheme(),
    );
  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: const MenuApp(),
    );
  }
}
