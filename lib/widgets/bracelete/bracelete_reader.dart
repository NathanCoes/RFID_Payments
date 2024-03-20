import 'package:flutter/material.dart';


class RfidBraceleteReader extends StatefulWidget {
  RfidBraceleteReader ({
    required this.nfcSession,
    super.key,
  });

  void Function() nfcSession;

  @override
  State<RfidBraceleteReader> createState() {
    return _RfidBraceleteReaderState();
  }
}

class _RfidBraceleteReaderState extends State<RfidBraceleteReader> {

  final _rfidReaderController = TextEditingController();

  @override
  void dispose() {
    _rfidReaderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context,) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return SizedBox(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                children: [
                  const Text("Acerca el dispositivo RFID"),
                  const Icon(
                    Icons.nfc_rounded,
                    size: 250
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 10,width: 10,),
                      ElevatedButton(
                        onPressed: (){
                          Navigator.pop(context);
                        }, 
                        child: const Text("Cancelar"),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      )
    );
  }
}