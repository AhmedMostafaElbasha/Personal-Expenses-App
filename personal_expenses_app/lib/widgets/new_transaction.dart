import 'package:flutter/material.dart';
import 'package:personal_expenses_app/widgets/user_transactions.dart';

class NewTransaction extends StatelessWidget {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final Function addNewTransactionHandler;

  NewTransaction({@required this.addNewTransactionHandler});

  void submitTransactionData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);
    
    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }
    
    addNewTransactionHandler(
                  title: enteredTitle,
                  amount: enteredAmount,
                );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                labelText: 'Title',
              ),
              // onChanged: (value) {
              //   titleInput = value;
              // },
              controller: titleController,
              onSubmitted: (_) => submitTransactionData(),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Amount',
              ),
              // onChanged: (value) => amountInput = value,
              controller: amountController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => submitTransactionData(),
            ),
            FlatButton(
              child: Text('Add Transaction'),
              onPressed: submitTransactionData,
              textColor: Colors.purple,
            ),
          ],
        ),
      ),
    );
  }
}
