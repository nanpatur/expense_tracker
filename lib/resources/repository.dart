import 'package:expense_tracker/database/database_controler.dart';
import 'package:expense_tracker/models/expense_model.dart';
import 'package:expense_tracker/services/auth_service.dart';

class Repository{
  final DatabaseController dbController = DatabaseController();
  final AuthService authService = AuthService();

  Future getAllExpenses() => dbController.getAllExpenses();

  Future insertExpense(ExpenseModel todo) => dbController.createExpense(todo);

  Future updateExpense(ExpenseModel todo) => dbController.updateExpense(todo);

  Future deleteExpense(int index) => dbController.deleteExpense(index);

  Future getUser() => authService.getUser();
}
