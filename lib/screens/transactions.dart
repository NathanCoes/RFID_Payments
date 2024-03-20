import 'package:flutter/material.dart';
import 'package:rfid_payments/data/dummy_transactions_data.dart';
import 'package:rfid_payments/models/rfid_transactions.dart';
import 'package:rfid_payments/widgets/transactions/transaction_create.dart';
import 'package:rfid_payments/widgets/transactions/transaction_list.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({Key? key}) : super(key: key);

  @override
  State<TransactionScreen> createState() {
    return _TransactionScreenState();
  }
}

class _TransactionScreenState extends State<TransactionScreen> {
  
  Widget content = const Text("Oops! No data found.");

  void _openFormNewUser() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context, 
      builder: (ctx) => NewTransaction(onCreate: _createTransaction),
    );
  }

  void _createTransaction(RfidTransactions rfidTrasaction){
    setState(() {
      transactionsDummy.add(rfidTrasaction);
    });
  }

  @override
  Widget build(BuildContext context) {

    if (transactionsDummy.isNotEmpty){
      content = ListView.builder(
        itemCount: transactionsDummy.length,
        itemBuilder: (ctx, index) => InkWell(
          splashColor: Theme.of(context).primaryColorDark,
          borderRadius: BorderRadius.circular(15),
          child: TransactionCard(transactionsDummy[index],)
        ),
      );
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        ElevatedButton(
          onPressed: _openFormNewUser, 
          child: const Text("Crear nueva transacción")
        ),
        const SizedBox(
          height: 5,
        ),
        const Text("Transacciones"),
        Expanded(child: content)
      ],
    );
  }
}
