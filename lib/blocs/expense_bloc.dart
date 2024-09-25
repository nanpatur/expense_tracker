import 'package:expense_tracker/models/expense_model.dart';
import 'package:expense_tracker/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class ExpenseBloc {
  final Repository repository = Repository();

  final PublishSubject<List<ExpenseModel>> _expenseFetcher = PublishSubject<List<ExpenseModel>>();

  Stream<List<ExpenseModel>> get allExpenses => _expenseFetcher.stream;
  Stream<int> get totalSumExpenses => _expenseFetcher.stream.map((event) => event.fold(0, (prev, element) => prev + (element.amount ?? 0)));

  ExpenseBloc(){
    getAllExpenses();
  }

  getAllExpenses() async {
    List<ExpenseModel> expense = await repository.getAllExpenses();
    _expenseFetcher.sink.add(expense);
  }

  addExpense(ExpenseModel expense) async {
    try {
      await repository.insertExpense(expense);
      getAllExpenses();
      
    } catch (e) {
      throw Exception(e);
    }
  }

  updateExpense(ExpenseModel expense) async {
    repository.updateExpense(expense);
    getAllExpenses();
  }

  deleteExpense(int id) async {
    repository.deleteExpense(id);
    getAllExpenses();
  }


}

final expenseBloc = ExpenseBloc();
