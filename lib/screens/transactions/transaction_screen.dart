import 'package:flutter/material.dart';

class TranscationScreen extends StatelessWidget {
  const TranscationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsetsDirectional.all(25),
      itemBuilder: (ctx, index) {
        return Card(
          elevation: 0,
          child: ListTile(
            shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color:Color.fromARGB(159, 89, 17, 176)
            ),
          ),
            title: Text("Expense"),
            subtitle: Text("12/09/2023"),
            trailing: Text(
              "Rs.5000",
              textAlign:TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                   color: Colors.green[400],
                   fontSize: 18
                   ),
            ),
            tileColor: Color.fromARGB(121, 221, 221, 221),
          ),
        );
      },
      separatorBuilder: (ctx, index) {
        return const SizedBox(height: 10);
      },
      itemCount: 10,
    );
  }
}
