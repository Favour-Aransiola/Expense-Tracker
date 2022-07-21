import 'package:expense_tracker/models/transactionModel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatefulWidget {
  List<TransactionModel> transaction;
  Function removeItem;
  TransactionList(
      {Key? key, required this.transaction, required this.removeItem})
      : super(key: key);

  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  @override
  Widget build(BuildContext context) {
    List<TransactionModel> trxList = widget.transaction;
    return Container(
      height: 500,
      child: ListView.builder(
        // reverse: true,
        itemBuilder: ((context, index) => Card(
                child: Container(
              width: double.infinity,
              height: 100,
              child: ListTile(
                title: Text(
                  trxList[index].title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                    DateFormat('EEE, yyyy-MM-dd').format(trxList[index].date),
                    style: TextStyle(color: Colors.grey[500])),
                leading: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.purple,
                      width: 2,
                    ),
                  ),
                  alignment: Alignment.center,
                  width: 100,
                  child: Text(
                    '\$ ${trxList[index].amount.toStringAsFixed(2)}',
                    style: TextStyle(
                        color: Colors.purple, fontWeight: FontWeight.bold),
                  ),
                ),
                trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      widget.removeItem(trxList[index]);
                    }),
              ),
            ))),
        itemCount: trxList.length,
      ),
    );
  }
}
