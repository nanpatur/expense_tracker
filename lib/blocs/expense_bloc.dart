import 'package:expense_tracker/models/expense_model.dart';
import 'package:expense_tracker/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class ExpenseBloc {
  final Repository repository = Repository();

  final PublishSubject<List<ExpenseModel>> _expenseFetcher = PublishSubject<List<ExpenseModel>>();

  Stream<List<ExpenseModel>> get allExpenses => _expenseFetcher.stream;

  ExpenseBloc(){
    getAllExpenses();
  }

  getAllExpenses() async {
    List<ExpenseModel> todo = await repository.getAllExpenses();
    _expenseFetcher.sink.add(todo);
  }

  addExpense(ExpenseModel todo) async {
    try {
      await repository.insertExpense(todo);
      getAllExpenses();
      
    } catch (e) {
      throw Exception(e);
    }
  }

  updateExpense(ExpenseModel todo) async {
    repository.updateExpense(todo);
    getAllExpenses();
  }

  deleteExpense(int id) async {
    repository.deleteExpense(id);
    getAllExpenses();
  }

}

final expenseBloc = ExpenseBloc();
