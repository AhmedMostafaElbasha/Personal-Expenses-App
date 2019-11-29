import 'package:flutter/material.dart';

import '../models/transaction.dart';
import '../widgets/transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> userTransctions;
  final Function deleteTransaction;

  const TransactionList(
      {@required this.userTransctions, @required this.deleteTransaction});

  @override
  Widget build(BuildContext context) {
    return userTransctions.isEmpty
        ? LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                children: <Widget>[
                  Text(
                    'No transactions added yet!',
                    style: Theme.of(context).textTheme.title,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            },
          )
        : ListView(
            children: userTransctions
                .map((transaction) => TransactionItem(
                      key: ValueKey(transaction.id),
                      transaction: transaction,
                      deleteTransaction: deleteTransaction,
                    ))
                .toList(),
          );
  }
}
