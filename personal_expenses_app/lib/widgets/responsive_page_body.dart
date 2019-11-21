import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../widgets/chart.dart';
import '../models/transaction.dart';
import '../widgets/transaction_list.dart';

class ResponsivePageBody extends StatefulWidget {
  final PreferredSizeWidget appBar;
  final List<Transaction> userTransactions;
  final Function deleteTransactionHandler;
  final List<Transaction> recentTransactions;
  bool showChart;

  ResponsivePageBody({
    @required this.appBar,
    @required this.userTransactions,
    @required this.deleteTransactionHandler,
    @required this.recentTransactions,
    @required this.showChart
  });

  @override
  _ResponsivePageBodyState createState() => _ResponsivePageBodyState();
}

class _ResponsivePageBodyState extends State<ResponsivePageBody> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    final isLandscape = mediaQuery.orientation == Orientation.landscape;

    final transactionListWidget = Container(
      height: (mediaQuery.size.height -
              widget.appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.7,
      child: TransactionList(
        userTransctions: widget.userTransactions,
        deleteTransaction: widget.deleteTransactionHandler,
      ),
    );

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (isLandscape)
              Container(
                height: (mediaQuery.size.height -
                        widget.appBar.preferredSize.height -
                        mediaQuery.padding.top) *
                    0.2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Show Chart ',
                      style: Theme.of(context).textTheme.title,
                    ),
                    Switch.adaptive(
                      activeColor: Theme.of(context).accentColor,
                      value: widget.showChart,
                      onChanged: (value) {
                        setState(() {
                          widget.showChart = value;
                        });
                      },
                    )
                  ],
                ),
              ),
            if (!isLandscape)
              Container(
                  height: (mediaQuery.size.height -
                          widget.appBar.preferredSize.height -
                          mediaQuery.padding.top) *
                      0.3,
                  child: Chart(
                    recentTransactions: widget.recentTransactions,
                  )),
            if (!isLandscape) transactionListWidget,
            if (isLandscape)
            widget.showChart
                  ? Container(
                      height: (mediaQuery.size.height -
                              widget.appBar.preferredSize.height -
                              mediaQuery.padding.top) *
                          0.6,
                      child: Chart(
                        recentTransactions: widget.recentTransactions,
                      ))
                  : transactionListWidget,
          ],
        ),
      ),
    );
  }
}
