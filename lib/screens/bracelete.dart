import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:rfid_payments/data/dummy_bracelete_data.dart';
import 'package:rfid_payments/models/bracelete.dart';
import 'package:rfid_payments/widgets/bracelete/bracelate_update.dart';
import 'package:rfid_payments/widgets/bracelete/bracelete_create.dart';
import 'package:rfid_payments/widgets/bracelete/bracelete_reader.dart';


class RfidBraceleteScreen extends StatefulWidget {
  const RfidBraceleteScreen({Key? key}) : super(key: key);

  @override
  State<RfidBraceleteScreen> createState() {
    return _TransactionScreenState();
  }
}

class _TransactionScreenState extends State<RfidBraceleteScreen> {
  String _rfidData = 'No RFID detected';
  String option = "create";

  void _showLayout(){
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context, 
      builder: (ctx) => RfidBraceleteReader(nfcSession: _readRfid),
    );
  }

  void _showForm(tagId){
    Widget layout = UpdateBracelete(
      data: tagId, 
      onUpdate: _updateBracelete, 
      onDelete: _deteleBrecelete
    );

    if (option == "create")  {
      layout = NewRfidBracelete(onCreate: _createBracelete, tagId: tagId);
    }
  }
  

  Future<void> _readRfid() async {
    try {
      NFCTag tag = await FlutterNfcKit.poll();
      if (tag != null) {
        setState(() {
          _rfidData = tag.id ?? 'No ID found';
        });
        
        if (option == "create"){
          _showForm(_rfidData);
        }

        if (option == "update"){
          _showForm(_rfidData);
        }
      }
    } catch (e) {
      print('Error reading NFC: $e');
      _showDialog("Error con RFID", "No he podido ser capaz de leer el dispositivo.");
    }
  }


  void _createBracelete(RfidBracelete rfidBracelete){
    setState(() {
      braceleteDummy.add(rfidBracelete);
    });
  }

  void _deteleBrecelete(RfidBracelete rfidBracelete){
    setState(() {
      braceleteDummy.removeWhere((braceleteData) => braceleteData.rif == rfidBracelete.rif);
    });
    Navigator.pop(context);
  }

  void _updateBracelete(RfidBracelete rfidBracelete){
    setState(() {
      braceleteDummy.forEach((braceleteData) {
        if (braceleteData.rif == rfidBracelete.rif) {
          braceleteData.banco = rfidBracelete.banco;
          braceleteData.phone = rfidBracelete.phone;
          braceleteData.pin = rfidBracelete.pin;
          print(rfidBracelete.banco);
        }
      });
    });
    Navigator.pop(context);
  }

  void _showDialog(String title, String msg){
    if (Platform.isIOS){
      showCupertinoDialog(context: context, builder: (ctx) => 
        CupertinoAlertDialog(
          title: Text(title),
          content: Text(msg),
          actions: [
            TextButton(onPressed: (){
                Navigator.pop(context);
              }, 
              child: const Text('Ok')
            )
          ],
        )
      );
    }else{
      showDialog(
        context: context, 
        builder: (ctx) => AlertDialog(
          title: Text(title),
          content: Text(msg),
          actions: [
            TextButton(onPressed: (){
                Navigator.pop(context);
              }, 
              child: const Text('Ok')
            )
          ],
        ),
      ); 
    }
  }

  void _testUpdate(){
    var data;
      braceleteDummy.forEach((braceleteData) {
        data = braceleteData.rif == "TagId" 
        ? RfidBracelete(
            banco: braceleteData.banco, 
            rif: "TagId", 
            phone: braceleteData.phone, 
            pin: braceleteData.pin
          )
        : "No data found";
      });
      
      if (data == "No data found"){
        _showDialog("Problemas con el brazalete", "Al parecer no tienes registrado el bracelete!");
      }else{
        showModalBottomSheet(
          useSafeArea: true,
          isScrollControlled: true,
          context: context, 
          builder: (ctx) => UpdateBracelete(data: data, onUpdate: _updateBracelete, onDelete: _deteleBrecelete),
          // builder: (ctx) => NewRfidBracelete(onCreate: _createBracelete, tagId: "tagId"),
        );
      }
  }

  void _testCreate(){
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context, 
      builder: (ctx) => NewRfidBracelete(onCreate: _createBracelete, tagId: "tagId"),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: (){
            _testCreate();
            // _showLayout();
          }, 
          child: const Text("Nuevo brazalete")
        ),
        ElevatedButton(
          onPressed: (){
            _testUpdate();
            // _showLayout();
          }, 
          child: const Text("Checar brazalete")
        ),
      ],
    );
  }
}
