import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rfid_payments/models/rfid_transactions.dart';

class NewTransaction extends StatefulWidget {
  const NewTransaction ({
    super.key,
    required this.onCreate,
  });

final void Function(RfidTransactions transaction) onCreate;

  @override
  State<NewTransaction> createState() {
    return _NewTransactionState();
  }
}

class _NewTransactionState extends State<NewTransaction> {

  final _montoController = TextEditingController();
  final _pinController = TextEditingController();

  void _showDialog(){
    if (Platform.isIOS){
      showCupertinoDialog(context: context, builder: (ctx) => 
        CupertinoAlertDialog(
          title: const Text('Input invalido'),
          content: const Text('Por favor, aseguraté de que todos los campos esten correctamente llenados.'),
          actions: [
            TextButton(onPressed: (){
                Navigator.pop(context);
              }, 
              child: const Text('Vale')
            )
          ],
        )
      );
    }else{
      showDialog(
        context: context, 
        builder: (ctx) => AlertDialog(
          title: const Text('Input invalido'),
          content: const Text('Por favor, aseguraté de que todos los campos esten correctamente llenados.'),
          actions: [
            TextButton(onPressed: (){
                Navigator.pop(context);
              }, 
              child: const Text('Vale')
            )
          ],
        ),
      ); 
    }
  }

  void _submitData(){

    if ( _montoController.text.trim().isEmpty 
      || _pinController.text.trim().isEmpty
    ){
      _showDialog();
      return;
    }

    widget.onCreate(
      RfidTransactions(
        encryptedData: "1aae3b64-e8b5-4f31-9f29-2f77fd18eefd",
        fechaEncriptacion: "46f6939f-592d-47cf-9db3-4731ea08bc20",
        monto: _montoController.text,
        pin: _pinController.text,
        postId: "b66fb223-fba9-492e-b571-b29c31ed6f41",
      )
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _montoController.dispose();
    _pinController.dispose();
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
                  const Text("Nueva transacciòn"),
                  TextField(
                    controller: _montoController,
                    maxLength: 7,
                    decoration: const InputDecoration(
                      label: Text('Monto')
                    ),
                  ),
                  TextField(
                    controller: _pinController,
                    maxLength: 5,
                    decoration: const InputDecoration(
                      label: Text('Pin')
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: _submitData,
                        child: const Text("Create"),
                      ),
                      const SizedBox(height: 10,width: 10,),
                      ElevatedButton(
                        onPressed: (){
                          Navigator.pop(context);
                        }, 
                        child: const Text("Cancel"),
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