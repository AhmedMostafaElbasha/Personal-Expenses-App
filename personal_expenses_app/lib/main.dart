import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: "Personal Expenses",
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final List<Transaction> transactions = [
    Transaction(
      id: "t1",
      title: "New Shoes",
      amount: 69.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: "t2",
      title: "Weekly Groceries",
      amount: 16.53,
      date: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Expenses'),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            width: double.infinity,
            child: Card(
              color: Colors.blue,
              child: Text(
                'CHART!',
              ),
              elevation: 5,
            ),
          ),
          
          Column(
            children: transactions.map(
              (transaction) {
                return Card(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 15,
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(
                          color: Colors.purple,
                          width: 2,
                        )),
                        padding: EdgeInsets.all(10),
                        child: Text(
                          '\$${transaction.amount}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.purple),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            transaction.title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            DateFormat.yMMMd().format(transaction.date),
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
            ).toList(),
          ),
        ],
      ),
    );
  }
}
