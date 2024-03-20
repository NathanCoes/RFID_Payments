import 'package:flutter/material.dart';
import 'package:rfid_payments/models/rfid_transactions.dart';

class TransactionCard extends StatelessWidget {

  const TransactionCard(
    this.transactionData,
    {
      super.key
    }
  );

  final RfidTransactions transactionData;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.grey[200],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            transactionData.monto,
            style: Theme.of(context).textTheme.headline6!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
          Text(
            transactionData.pin,
            style: Theme.of(context).textTheme.subtitle1!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
        ],
      ),
    );
  }
}