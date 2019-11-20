import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> userTransctions;
  final Function deleteTransaction;

  TransactionList(
      {@required this.userTransctions, @required this.deleteTransaction});

  @override
  Widget build(BuildContext context) {
    return userTransctions.isEmpty
        ? LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                children: <Widget>[
                  Container(
                    height: constraints.maxHeight * 0.2,
                    child: Text(
                      'No transactions added yet!',
                      style: Theme.of(context).textTheme.title,
                    ),
                  ),
                  SizedBox(
                    height: constraints.maxHeight * 0.10,
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
        : ListView.builder(
            itemBuilder: (context, index) {
              return Card(
                margin: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 5,
                ),
                elevation: 5,
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: EdgeInsets.all(6),
                      child: FittedBox(
                        child: Text(
                          '\$${userTransctions[index].amount.toStringAsFixed(2)}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    userTransctions[index].title,
                    style: Theme.of(context).textTheme.title,
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd().format(userTransctions[index].date),
                  ),
                  trailing: MediaQuery.of(context).size.width > 460
                      ? FlatButton.icon(
                          icon: Icon(Icons.delete),
                          textColor: Theme.of(context).errorColor,
                          onPressed: () =>
                              deleteTransaction(userTransctions[index].id),
                          label: Text('Delete'),
                        )
                      : IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () =>
                              deleteTransaction(userTransctions[index].id),
                          color: Theme.of(context).errorColor,
                        ),
                ),
              );
            },
            itemCount: userTransctions.length,
          );
  }
}
