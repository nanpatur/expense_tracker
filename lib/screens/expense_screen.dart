import 'package:expense_tracker/blocs/expense_bloc.dart';
import 'package:expense_tracker/widgets/organisms/add_expense_form.dart';
import 'package:expense_tracker/widgets/templates/expense_template.dart';
import 'package:flutter/material.dart';

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({super.key});

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {

  @override
  Widget build(BuildContext context) {
    expenseBloc.getAllExpenses();
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: const ExpenseTemplate(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) {
                return const AddExpenseForm();
              });
        },
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(28))),
        backgroundColor: Colors.grey.shade900,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
