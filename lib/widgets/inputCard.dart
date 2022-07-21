import 'package:expense_tracker/models/transactionModel.dart';
import 'package:expense_tracker/widgets/transactionList.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InputCard extends StatefulWidget {
  Function addTrx;
  TextEditingController nameController;
  TextEditingController priceController;
  DateTime dateController;
  BuildContext ctx;
  InputCard(
      {Key? key,
      required this.addTrx,
      required this.nameController,
      required this.priceController,
      required this.dateController,
      required this.ctx})
      : super(key: key);

  @override
  State<InputCard> createState() => _InputCardState();
}

class _InputCardState extends State<InputCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
          padding: EdgeInsets.all(8),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            TextField(
              controller: widget.nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: widget.priceController,
              decoration: InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            TextButton(
              onPressed: () async {
                var date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now());
                if (date != null) {
                  widget.dateController = date;
                } else {
                  widget.dateController = DateTime.now();
                }
              },
              child: Text('Pick Date'),
            ),
            ElevatedButton(
                onPressed: (() {
                  widget.addTrx(
                    widget.nameController.text,
                    widget.priceController.text,
                    context,
                    widget.dateController,
                  );
                }),
                child: Text('Submit'))
          ])),
    );
  }
}
