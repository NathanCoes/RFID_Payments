import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rfid_payments/models/user.dart';

class NewUser extends StatefulWidget {
  const NewUser ({
    super.key,
    required this.onCreate,
  });

final void Function(Users user) onCreate;

  @override
  State<NewUser> createState() {
    return _NewUserState();
  }
}

class _NewUserState extends State<NewUser> {

  final _bankNameController = TextEditingController();
  final _rifController = TextEditingController();
  final _phoneController = TextEditingController();
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

    if ( _bankNameController.text.trim().isEmpty 
      || _rifController.text.trim().isEmpty  
      || _phoneController.text.trim().isEmpty 
      || _pinController.text.trim().isEmpty 
    ){
      _showDialog();
      return;
    }

    widget.onCreate(
      Users(
        banco: _bankNameController.text, 
        rif: _rifController.text, 
        phone: _phoneController.text, 
        pin: _pinController.text
      )
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _bankNameController.dispose();
    _rifController.dispose();
    _phoneController.dispose();
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
                  const Text("User information"),
                  TextField(
                    controller: _bankNameController,
                    maxLength: 30,
                    decoration: const InputDecoration(
                      label: Text('Nombre del banco')
                    ),
                  ),
                  TextField(
                    controller: _rifController,
                    maxLength: 50,
                    decoration: const InputDecoration(
                      label: Text('RIF')
                    ),
                  ),
                  TextField(
                    controller: _phoneController,
                    maxLength: 11,
                    decoration: const InputDecoration(
                      label: Text('Número celular')
                    ),
                  ),
                  TextField(
                    controller: _pinController,
                    maxLength: 10,
                    decoration: const InputDecoration(
                      label: Text('PIN')
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