import 'package:ac_exp_tracker/services/data_service.dart';
import 'package:flutter/material.dart';
import 'transaction_tile.dart';
import 'waiting.dart';

class TransactionList extends StatelessWidget {
  final DataService data;
  final Function onDelete;
  const TransactionList({Key? key, required this.data, required this.onDelete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return data.transactions.isNotEmpty
        ? ListView.builder(
            itemCount: data.transactions.length,
            itemBuilder: (BuildContext context, int index) {
              return TransactionTile(
                // key: ValueKey(data.transactions[index].id),
                transaction: data.transactions[index],
                onDelete: onDelete,
              );
            },
          )
        : const Waiting();
  }
}
