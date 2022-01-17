import 'package:flutter/material.dart';
import '../displayed/date.dart';
import '../displayed/price.dart';
import '../displayed/titleDisplay.dart';
import '../forms/actions.dart';

class Transactions extends StatelessWidget {
  final List transactions;
  final Function deleteActionHandler;

  const Transactions(
      {required this.transactions, required this.deleteActionHandler});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (e, index) {
        return Card(
          elevation: 5,
          margin: EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 5,
          ),
          child: ListTile(
              leading: Price(
                amount: transactions[index].amount.toStringAsFixed(2),
              ),
              title: TitleDisplay(title: transactions[index].title),
              subtitle: DateDisplay(date: transactions[index].date),
              trailing: ActionList(
                  id: transactions[index].id,
                  deleteTransactionHandler: deleteActionHandler)),
        );
      },
      itemCount: transactions.length,
    );
  }
}
