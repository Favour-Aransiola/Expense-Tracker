import 'package:flutter/material.dart';

class ExpenseChart extends StatefulWidget {
  ExpenseChart({Key? key}) : super(key: key);

  @override
  State<ExpenseChart> createState() => _ExpenseChartState();
}

class _ExpenseChartState extends State<ExpenseChart> {
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        child: Container(
            alignment: Alignment.center,
            height: 50,
            color: Colors.green,
            width: double.infinity,
            child: Text('CHART')));
  }
}
