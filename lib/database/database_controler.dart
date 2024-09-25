import 'package:expense_tracker/models/expense_model.dart';
import 'package:expense_tracker/database/database.dart';

class DatabaseController{
  final dbClient = DatabaseProvider.dbProvider;

  Future<int> createExpense(ExpenseModel expense) async {
    final db = await dbClient.db;
    var result = db.insert("expenseTable", expense.toJSON());
    return result;
  }

// add optional filter by date range
  Future<List<ExpenseModel>> getAllExpenses({List<String>? columns}) async {
    final db = await dbClient.db;
    var result = await db.query("expenseTable",columns: columns);
    List<ExpenseModel> expenses = result.isNotEmpty ? result.map((item) => ExpenseModel.fromJSON(item)).toList() : [];
    return expenses;
  }

  Future<int> updateExpense(ExpenseModel expense) async {
    final db = await dbClient.db;
    var result = await db.update("expenseTable", expense.toJSON(),where: "id = ?", whereArgs: [expense.id]);
    return result;
  }

  Future<int> deleteExpense(int id) async {
    final db = await dbClient.db;
    var result = await db.delete("expenseTable", where: 'id = ?', whereArgs: [id]);

    return result;
  }
}
