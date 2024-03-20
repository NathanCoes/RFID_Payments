import 'package:flutter/material.dart';
import 'package:rfid_payments/models/user.dart';

class UpdateUser extends StatefulWidget {
  UpdateUser ({
    super.key,
    required this.userData,
    required this.onUpdate,
    required this.onDelete
  });

final void Function(Users user) onUpdate;
final void Function(Users user) onDelete;
final Users userData;

  @override
  State<UpdateUser> createState() {
    return _UpdateUserState();
  }
}

class _UpdateUserState extends State<UpdateUser> {

  late TextEditingController _bankNameController;
  late TextEditingController _phoneController;
  late TextEditingController _pinController;

  @override
  void initState() {
    super.initState();
    _bankNameController = TextEditingController(text: widget.userData.banco);
    _phoneController = TextEditingController(text: widget.userData.phone);
    _pinController = TextEditingController(text: widget.userData.pin);
  }

  @override
  void dispose() {
    _bankNameController.dispose();
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
                            Users(
                              banco: _bankNameController.text, 
                              rif: widget.userData.rif, 
                              phone: _phoneController.text, 
                              pin: _pinController.text
                            )
                          );
                        },
                        child: const Text("Save changed"),
                      ),
                      const SizedBox(height: 10,width: 10,),
                      ElevatedButton(
                        onPressed: (){}, 
                        child: const Text("Transactions"),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: (){}, 
                        child: const Text("POS"),
                      ),
                      const SizedBox(height: 10,width: 10,),
                      ElevatedButton(
                        onPressed: (){widget.onDelete(widget.userData);}, 
                        child: const Text("Delete User"),
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