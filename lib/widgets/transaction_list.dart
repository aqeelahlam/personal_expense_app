import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> userTransactions;
  final Function deleteTx;

  TransactionList(this.userTransactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return userTransactions.isEmpty
        ? LayoutBuilder(builder: (context, contraints) {
            return Column(
              children: [
                Text(
                  "No Transactions add yet!",
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                  height: contraints.maxHeight * 0.6,
                )
              ],
            );
          })
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: FittedBox(
                          child: Text('\$${userTransactions[index].amount}')),
                    ),
                  ),
                  title: Text(
                    userTransactions[index].title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  subtitle: Text(
                      DateFormat.yMMMd().format(userTransactions[index].date)),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    color: Theme.of(context).errorColor,
                    onPressed: () => deleteTx(userTransactions[index].id),
                  ),
                ),
              );
            },
            itemCount: userTransactions.length,
          );
  }
}
