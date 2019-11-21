import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses_app/widgets/adaptive_flat_button.dart';
import 'package:personal_expenses_app/widgets/adaptive_raised_button.dart';
import 'package:personal_expenses_app/widgets/adaptive_text_field.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTransactionHandler;

  NewTransaction({@required this.addNewTransactionHandler});

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _submitTransactionData() {
    if (_amountController.text.isEmpty) {
      return;
    }

    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.addNewTransactionHandler(
        title: enteredTitle, amount: enteredAmount, chosenDate: _selectedDate);

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    Platform.isIOS ? showCupertinoModalPopup(context: context, builder: (builderContext) {
      CupertinoDatePicker _cupertinoDatePicker = CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: DateTime.now(),
                  minimumDate: DateTime(2019),
                  maximumDate: DateTime.now(),
                  minimumYear: 2019,
                  maximumYear: int.parse(DateFormat.y().format(DateTime.now())),
                  onDateTimeChanged: (selectedDate) {
                    if (selectedDate == null) {
                      return;
                    }
                    setState(() {
                      _selectedDate = selectedDate;
                    });
                  },
                );
      return LayoutBuilder(builder: (builderContext, constraints) {
        return SafeArea(
          child: Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Padding(padding: EdgeInsets.only(top:constraints.maxHeight * 0.01,)),
                Container(height: constraints.maxHeight * 0.05 ,child: Text('Expense Date', style: Theme.of(context).textTheme.title,)),
                SizedBox(height: constraints.maxHeight *0.02,),
                Container(
                  height: constraints.maxHeight * 0.4,
                  child: _cupertinoDatePicker
                ),
                SizedBox(height: constraints.maxHeight *0.02,),
                Container(
                  height: constraints.maxHeight * 0.10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      AdaptiveFlatButton(
                        title: 'Done',
                        handler: () {
                          Navigator.pop(context);
                        },
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      });
    }) : showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((selectedDate) {
      if (selectedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = selectedDate;
      });
    });
    print('...');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Card(
          elevation: 5,
          child: Container(
            padding: EdgeInsets.only(
              top: 10,
              right: 10,
              left: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                AdaptiveTextField(
                  controller: _titleController,
                  handler: _submitTransactionData,
                  title: 'Title',
                  textInputType: TextInputType.text,
                ),
                SizedBox(
                  height: 10,
                ),
                AdaptiveTextField(
                  title: 'Amount',
                  controller: _amountController,
                  handler: _submitTransactionData,
                  textInputType: TextInputType.numberWithOptions(decimal: true),
                ),
                Container(
                  height: 60,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          _selectedDate == null
                              ? 'No Date Chosen!'
                              : 'Selected Date: ${DateFormat.yMd().format(_selectedDate)}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      AdaptiveFlatButton(
                        title: 'Choose Date',
                        handler: _presentDatePicker,
                      ),
                    ],
                  ),
                ),
                AdaptiveRaisedButton(
                  handler: _submitTransactionData,
                  title: 'Add Transaction',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
