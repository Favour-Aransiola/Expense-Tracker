import 'package:expense_tracker/models/transactionModel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';

class Chart extends StatelessWidget {
  List<TransactionModel> recentTransaction;
  Chart({Key? key, required this.recentTransaction}) : super(key: key);

  List<Map<String, Object>> groupedTransation() {
    return List.generate(7, (index) {
      DateTime currDate = DateTime.now().subtract(Duration(days: index));
      double amount = 0.0;
      for (int i = 0; i < recentTransaction.length; i++) {
        if (recentTransaction[i].date.day == currDate.day &&
            recentTransaction[i].date.month == currDate.month &&
            recentTransaction[i].date.year == currDate.year) {
          amount += recentTransaction[i].amount;
        }
      }

      return {'day': DateFormat.E().format(currDate), 'amount': amount};
    });
  }

  double getMaxAmount() {
    double highest = 0;
    for (var i in groupedTransation()) {
      if (i['amount'] as double > highest) {
        highest = i['amount'] as double;
      }
    }
    return highest + 100;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 6,
        margin: EdgeInsets.all(20),
        child: Container(
          width: double.infinity,
          height: 300,
          child: BarChart(
            BarChartData(
                alignment: BarChartAlignment.center,
                maxY: getMaxAmount(),
                minY: 0,
                titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (index, j) {
                              return Text(groupedTransation()[index.round() - 1]
                                      ['day']
                                  .toString());
                            }))),
                barGroups: groupedTransation()
                    .map((e) => BarChartGroupData(
                            x: groupedTransation().indexWhere((element) =>
                                    e.toString() == element.toString()) +
                                1,
                            barRods: [
                              BarChartRodData(
                                  toY: e['amount'] as double,
                                  fromY: 0,
                                  width: 20,
                                  color: Colors.purple,
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(5)))
                            ]))
                    .toList()),
            swapAnimationDuration: const Duration(milliseconds: 150),
            swapAnimationCurve: Curves.linear,
          ),
        ));
  }
}
