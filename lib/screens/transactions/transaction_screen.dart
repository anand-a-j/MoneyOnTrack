import 'package:flutter/material.dart';
import 'package:money_management_app/db/category/category_db.dart';
import 'package:money_management_app/db/transaction/transaction_db.dart';
import 'package:money_management_app/model/category/category_model.dart';

class TranscationScreen extends StatelessWidget {
  const TranscationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TransactionDB.instance.refresh();
    CategoryDB.instance.refreshUI();
    return ValueListenableBuilder(
      //--
      valueListenable: TransactionDB.instance.transactionsListListener, //--
      builder: (cxt, newList, _) {
        return ListView.separated(
          padding: EdgeInsetsDirectional.all(25),
          itemBuilder: (ctx, index) {
            final _values = newList[index]; //--
            return Card(
              elevation: 0,
              child: ListTile(
                shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      const BorderSide(color: Color.fromARGB(159, 89, 17, 176)),
                ),
                title: Text(_values.purpose),
                subtitle: Text(parseDate(_values.date)),
                trailing: Text(
                  currencyINR(_values.amount),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: _values.type == Categorytype.income
                          ? Colors.green[400]
                          : Colors.red[400],
                      fontSize: 18),
                ),
                tileColor: const Color.fromARGB(121, 221, 221, 221),
              ),
            );
          },
          separatorBuilder: (ctx, index) {
            return const SizedBox(height: 10);
          },
          itemCount: newList.length,
        );
      },
    );
  }

  String parseDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  String currencyINR(double amount) {
    return '₹$amount';
  }
}
