import 'package:expense_tracker/models/transactionModel.dart';
import 'package:expense_tracker/widgets/chart.dart';
import 'package:expense_tracker/widgets/expenseChart.dart';
import 'package:expense_tracker/widgets/inputCard.dart';
import 'package:expense_tracker/widgets/transactionList.dart';
import 'package:expense_tracker/widgets/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.amber,
            appBarTheme: AppBarTheme(
                textTheme: TextTheme(
                    titleMedium:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w900)))),
        home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final nameController = TextEditingController();

  final priceController = TextEditingController();
  DateTime dateController = DateTime.now();

  List<TransactionModel> trxs = [];
  addTrxs(String title, String amount, BuildContext ctx, DateTime date) {
    print(date);
    if (amount == '') {
      Navigator.of(ctx).pop();
      return;
    } else if (title.isNotEmpty && double.parse(amount) > 0) {
      setState(() {
        trxs = [
          ...trxs,
          TransactionModel(
              id: trxs.isEmpty ? 0 : trxs.last.id + 1,
              title: title,
              amount: double.parse(amount),
              date: date),
        ];
        nameController.text = '';
        priceController.text = '';
      });
    }
    Navigator.of(ctx).pop();
    return;
  }

  showMyBottomSheet(BuildContext context) {
    showModalBottomSheet(
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(40))),
        context: context,
        builder: (_) {
          return Container(
              child: InputCard(
            addTrx: addTrxs,
            nameController: nameController,
            priceController: priceController,
            dateController: dateController,
            ctx: context,
          ));
        });
  }

  removeItem(TransactionModel item) {
    setState(() {
      trxs.remove(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            showMyBottomSheet(context);
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        title: Text('Expense Tracker'),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.add))],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Chart(
                recentTransaction: trxs.where((element) {
              return element.date
                  .isAfter(DateTime.now().subtract(const Duration(days: 7)));
            }).toList()),
            TransactionList(
              transaction: trxs,
              removeItem: removeItem,
            )
          ],
        ),
      ),
    );
  }
}
