import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/chart.dart';
import 'package:personal_expense_app/widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import 'models/transaction.dart';

void main() {
  // To set a limit to how the user uses the app in which orientation

  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
              button: TextStyle(color: Colors.white)),
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                    headline6: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 20,
                    ),
                  ))),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  // String titleInput;
  // String amountInput;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransaction = [];

  bool _switchState = false;

  List<Transaction> get _recentTransactions {
    return _userTransaction.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(Duration(days: 7)),
      );
    }).toList();
  }

  void _addNewTransaction(String txTitle, double txAmount, DateTime dateTime) {
    final newTX = Transaction(
        id: DateTime.now().toString(),
        title: txTitle,
        amount: txAmount,
        date: dateTime);

    setState(() {
      _userTransaction.add(newTX);
    });
  }

  void _deleteTransactions(String id) {
    setState(() {
      _userTransaction.removeWhere((element) => element.id == id);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) => GestureDetector(
        child: NewTransaction(_addNewTransaction),
        onTap: () {},
        behavior: HitTestBehavior.opaque,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: const Text(
        "Personal Expenses",
        style: TextStyle(fontFamily: 'OpenSans'),
      ),
      actions: [
        IconButton(
            onPressed: () {
              return _startAddNewTransaction(context);
            },
            icon: const Icon(Icons.add))
      ],
    );
    final height = MediaQuery.of(context).size.height;
    final appBarHeight = appBar.preferredSize.height;
    final padding = MediaQuery.of(context).padding.top;

    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final txListWidget = Container(
        height: (height - appBarHeight - padding) * 0.7,
        child: TransactionList(_userTransaction, _deleteTransactions));

    return Scaffold(
        appBar: appBar,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              if (isLandscape)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Show Chart'),
                    Switch(
                        value: _switchState,
                        onChanged: (value) {
                          setState(() {
                            _switchState = value;
                          });
                        })
                  ],
                ),
              if (!isLandscape)
                Container(
                    height: (height - appBarHeight - padding) * 0.3,
                    child: Chart(_recentTransactions)),
              if (!isLandscape) txListWidget,
              if (isLandscape)
                _switchState
                    ? Container(
                        height: (height - appBarHeight - padding) * 0.7,
                        child: Chart(_recentTransactions))
                    : txListWidget
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () => _startAddNewTransaction(context),
          child: const Icon(Icons.add),
        ));
  }
}
