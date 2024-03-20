import 'package:flutter/material.dart';
import 'package:rfid_payments/data/dummy_bracelete_data.dart';
import 'package:rfid_payments/models/bracelete.dart';
import 'package:rfid_payments/models/user.dart';

class UpdateBracelete extends StatefulWidget {
  UpdateBracelete ({
    super.key,
    required this.data,
    required this.onUpdate,
    required this.onDelete
  });

final void Function(RfidBracelete rfidBracelete) onUpdate;
final void Function(RfidBracelete rfidBracelete) onDelete;
final RfidBracelete data;

  @override
  State<UpdateBracelete> createState() {
    return _UpdateBraceleteState();
  }
}

class _UpdateBraceleteState extends State<UpdateBracelete> {

  late TextEditingController _bankNameController;
  late TextEditingController _phoneController;
  late TextEditingController _pinController;
  late TextEditingController _rifController;

  @override
  void initState() {
    _bankNameController = TextEditingController(text: widget.data.banco);
    _phoneController = TextEditingController(text: widget.data.phone);
    _pinController = TextEditingController(text: widget.data.pin);
    _rifController = TextEditingController(text: widget.data.rif);
    super.initState();
  }

  @override
  void dispose() {
    _bankNameController.dispose();
    _phoneController.dispose();
    _pinController.dispose();
    _rifController.dispose();
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
                  const Text("Información de brazalete"),
                  TextField(
                    controller: _bankNameController,
                    maxLength: 30,
                    decoration: const InputDecoration(
                      label: Text('Nombre del banco')
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
                        onPressed: (){
                          widget.onUpdate(
                            RfidBracelete(
                              banco: _bankNameController.text, 
                              rif: _rifController.text, 
                              phone: _phoneController.text, 
                              pin: _pinController.text
                            )
                          );
                        },
                        child: const Text("Save changed"),
                      ),
                      const SizedBox(height: 10,width: 10,),
                      ElevatedButton(
                        onPressed: (){
                          widget.onDelete(
                            RfidBracelete(
                              banco: _bankNameController.text, 
                              rif: _rifController.text, 
                              phone: _phoneController.text, 
                              pin: _pinController.text
                            )
                          );
                        }, 
                        child: const Text("Borrar Brazalete"),
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