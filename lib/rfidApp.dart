import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rfid_payments/screens/bracelete.dart';
import 'package:rfid_payments/screens/transactions.dart';
import 'package:rfid_payments/screens/users.dart';
import 'package:rfid_payments/widgets/layout.dart';
import 'package:rfid_payments/widgets/menu.dart';

class RfidApp extends StatefulWidget {
  const RfidApp ( { super.key } );


  @override
  State<RfidApp> createState() {
    return _RfidAppState();
  }
}


class _RfidAppState extends State<RfidApp> {
  final theme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color.fromARGB(255, 32, 62, 113),
    ),
    textTheme: GoogleFonts.manjariTextTheme(),
  );

  
  var activeLayout = "menu";

  @override
  Widget build(context) {

    void showLayout(BuildContext context, String layout){
      var layoutScreen;

      switch (layout) {
        case "users":
          layoutScreen = const LayoutWidget(layoutWidget: UserScreen(), titleLayout: "Usuarios");
          break;
        case "transactions":
          layoutScreen = const LayoutWidget(layoutWidget: TransactionScreen(), titleLayout: "Transacciones");
          break;
        case "bracelete":
          layoutScreen = const LayoutWidget(layoutWidget: RfidBraceleteScreen(), titleLayout: "Brazaletes");
          break;
        default:
      }

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => layoutScreen,
        ),
      );
    }

    return MaterialApp(
      theme: theme,
      home: Scaffold(
        appBar:AppBar(
          title: const Text("RFID"),
          backgroundColor: Theme.of(context).primaryColorLight.withOpacity(.1),
        ),
        body: Container(
          width: double.maxFinite,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Theme.of(context).primaryColorLight.withOpacity(.1),
                  Theme.of(context).primaryColorLight.withOpacity(.4),
                ],
              ),
          ),
          child: MenuWidget(activeLayout: showLayout),
        ),
      )
    );
  }
}
