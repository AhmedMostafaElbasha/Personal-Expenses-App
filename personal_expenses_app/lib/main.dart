import 'dart:io';
import 'dart:ui' as prefix0;

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:personal_expenses_app/widgets/responsive_page_body.dart';

import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';
import './models/transaction.dart';

void main() {
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: "Personal Expenses",
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          //errorColor: Colors.red,
          primaryIconTheme: IconThemeData(color: Colors.white, size: 30),
          accentIconTheme: IconThemeData(color: Colors.white, size: 30),
          cursorColor: Colors.purple,
          hintColor: Colors.purple,
          fontFamily: 'QuickSand',
          textTheme: ThemeData.light().textTheme.copyWith(
              title: const TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              button:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                  title: const TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
          )),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  // String titleInput;
  // String amountInput;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  final List<Transaction> _userTransactions = [
    // Transaction(
    //   id: "t1",
    //   title: "New Shoes",
    //   amount: 69.99,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: "t2",
    //   title: "Weekly Groceries",
    //   amount: 16.53,
    //   date: DateTime.now(),
    // ),
  ];

  bool _showChart = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);
    print(state);
  }

  @override
  dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((transaction) {
      return transaction.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }

  void _addNewTransaction({
    @required String title,
    @required double amount,
    @required DateTime chosenDate,
  }) {
    final newTransaction = Transaction(
      title: title,
      amount: amount,
      date: chosenDate,
      id: DateTime.now().toString(),
    );
    setState(() {
      _userTransactions.add(newTransaction);
    });
  }

  void _startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        // Legacy.
        // In past we were need to add guestre detector to catch the touch event on modal sheet
        // so we can prevent the modal sheet from closing accidently.

        // return GestureDetector(
        //   child: NewTransaction(
        //     addNewTransactionHandler: _addNewTransaction,
        //   ),
        //   onTap: () {},
        //   behavior: HitTestBehavior.opaque,
        // );

        // But since this problem is solved we don't need this approach anymore.
        return NewTransaction(
          addNewTransactionHandler: _addNewTransaction,
        );
      },
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions
          .removeWhere((transactionElement) => transactionElement.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text(
              'Personal Expenses',
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  onTap: () => _startAddNewTransaction(context),
                  child: const Icon(CupertinoIcons.add),
                )
              ],
            ),
          )
        : AppBar(
            title: Text(
              'Personal Expenses',
            ),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () => _startAddNewTransaction(context),
                iconSize: 30,
              )
            ],
          );

    final pageBody = ResponsivePageBody(
      userTransactions: _userTransactions,
      appBar: appBar,
      deleteTransactionHandler: _deleteTransaction,
      showChart: _showChart,
      recentTransactions: _recentTransactions,
    );

    // TODO: implement build
    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
            navigationBar: appBar,
          )
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: const Icon(
                      Icons.add,
                      size: 30,
                    ),
                    onPressed: () => _startAddNewTransaction(context),
                  ),
            floatingActionButtonLocation:
                 FloatingActionButtonLocation.centerFloat,
          );
  }
}
