import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final Function addTX;
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  NewTransaction(this.addTX);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: "Title"),
              // onChanged: (val) {
              //   titleInput = val;
              // },
              controller: titleController,
            ),
            TextField(
              decoration: const InputDecoration(labelText: "Amount"),
              // onChanged: (val) => amountInput = val,
              controller: amountController,
            ),
            FlatButton(
                onPressed: () {
                  addTX(titleController.text,
                      double.parse(amountController.text));
                },
                child: const Text("Add Transaction"))
          ],
        ),
      ),
    );
  }
}
