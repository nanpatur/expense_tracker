import 'package:expense_tracker/database/database_controler.dart';
import 'package:expense_tracker/models/expense_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Repository{
  final DatabaseController dbController = DatabaseController();
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  Future getAllExpenses() => dbController.getAllExpenses();

  Future insertExpense(ExpenseModel todo) => dbController.createExpense(todo);

  Future updateExpense(ExpenseModel todo) => dbController.updateExpense(todo);

  Future deleteExpense(int index) => dbController.deleteExpense(index);
}
