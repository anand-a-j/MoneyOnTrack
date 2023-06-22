import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_management_app/model/transaction/transaction_model.dart';

// DB name
const TRANSACTION_DB_NAME = 'transacton-db';

abstract class TransactionDbFunctions {
  Future<void> addTransaction(TransactionModel obj);
  Future<List<TransactionModel>> getTransactions(); //--
}

class TransactionDB implements TransactionDbFunctions {
  // Singleton
  TransactionDB._internal();

  static TransactionDB instance = TransactionDB._internal();

  factory TransactionDB() {
    return instance;
  }

  ValueNotifier<List<TransactionModel>> transactionsListListener =
      ValueNotifier([]);

  @override
  Future<void> addTransaction(TransactionModel obj) async {
    final _db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    _db.put(obj.id, obj);
  }

  Future<void> refresh() async {
    final list = await getTransactions();
    list.sort((first, second) => second.date.compareTo(first.date));
    transactionsListListener.value.clear();
    transactionsListListener.value.addAll(list);
    transactionsListListener.notifyListeners();
  }

  @override
  Future<List<TransactionModel>> getTransactions() async {
    final _db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    return _db.values.toList();
  }
}
