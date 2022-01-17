import 'dart:math';
import 'dart:io';

import 'package:flutter/material.dart';

import './interface/transaction.dart';
import './widgets/forms/formspending.dart';
import './widgets/forms/toggle.dart';
import './widgets/chart/chart.dart';
import './widgets/transactions/transactions.dart';
import './widgets/displayed/noresult.dart';
import './widgets/buttons/mainfloatingbutton.dart';

void main() {

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Personal Expenses',
      home: Home(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
          headline6: const TextStyle(
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        appBarTheme: const AppBarTheme(
            toolbarTextStyle:TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 20,
              ),
    ),
      ),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _isChart = false;
  final List<Transaction> _transactions = [];

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () => {},
          child: FormSpending(
            transactions: _transactions,
            submitFormHandler: _submitFormHandler,
          ),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  String generateRandomString(int len) {
    var r = Random();
    return String.fromCharCodes(
        List.generate(len, (index) => r.nextInt(33) + 89));
  }

  void _submitFormHandler(String title, double amount, DateTime chosenDate) {
    if (title.isEmpty || amount <= 0 || chosenDate == null) {
      return;
    }
    String unique_id = generateRandomString(15);
    setState(() {
      _transactions.add(
        Transaction(
          id: unique_id,
          title: title,
          amount: amount,
          date: chosenDate,
        ),
      );
    });
    // Navigator.of(context).pop();
  }

  void _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((element) {
        return element.id == id;
      });
    });
  }

  void _showChart(bool val) {
    setState(() {
      _isChart = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context);
    final _isLandscape = _mediaQuery.orientation == Orientation.landscape;
    final appbar = AppBar(
      title: Text(
        'Expense Tracker',
      ),
      actions: <Widget>[
        IconButton(
          onPressed: () => _startAddNewTransaction(context),
          icon: Icon(
            Icons.add_outlined,size: 35,
          ),
        ),
      ],
    );

    double _mediaQueryMultiplier = !_isLandscape ? 0.3 : 0.7;

    final widgetTransactions = Container(
      height: (_mediaQuery.size.height +
          appbar.preferredSize.height +
          _mediaQuery.padding.top) *
          _mediaQueryMultiplier + 200,
      child: _transactions.isEmpty
          ? NoResult()
          : Transactions(
        transactions: _transactions,
        deleteActionHandler: _deleteTransaction,
      ),
    );

    return Scaffold(

      floatingActionButton: Platform.isIOS
          ? Container()
          : MainFloatingButton(context, _startAddNewTransaction),
      floatingActionButtonLocation:
      FloatingActionButtonLocation.miniCenterFloat,
      appBar: appbar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (_isLandscape)
              ToggleSwitch(
                isChart: _isChart,
                showChart: _showChart,
              ),
            _isChart || !_isLandscape
                ? Container(
              height: (_mediaQuery.size.height -
                  appbar.preferredSize.height -
                  _mediaQuery.padding.top) *
                  _mediaQueryMultiplier,
              padding: EdgeInsets.all(4),
              child: Chart(
                recentTransactions: _transactions,
              ),
            )
                : widgetTransactions,
            if (!_isLandscape) widgetTransactions
          ],
        ),
      ),
    );
  }
}
