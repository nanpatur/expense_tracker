import 'package:expense_tracker/blocs/expense_bloc.dart';
import 'package:expense_tracker/models/expense_model.dart';
import 'package:expense_tracker/widgets/atoms/button.dart';
import 'package:expense_tracker/widgets/atoms/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddExpenseForm extends StatefulWidget {
  const AddExpenseForm({
    super.key,
  });

  @override
  _AddExpenseFormState createState() => _AddExpenseFormState();
}

class _AddExpenseFormState extends State<AddExpenseForm> {
  int? amount;
  String? description;
  String? category;
  DateTime? date = DateTime.now();
  final _formKey = GlobalKey<FormState>(debugLabel: 'add_expense');

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.80,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
      child:
    Form(
      key: _formKey,
      child: 
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('Add New Expense',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left),
                const SizedBox(height: 10),
                const Text(
                    'Enter the details of your expense to help you track your spending.',
                    style: TextStyle(fontSize: 14)),
                const SizedBox(height: 32),
          ETTextFormField(
            label: "Enter Amount (Rp)",
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                amount = int.parse(value!);
              });
            },
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter amount';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 10.0,
          ),
          ETTextFormField(
            label: "Enter Description",
            keyboardType: TextInputType.text,
            onChanged: (value) {
              setState(() {
                description = value;
              });
            },
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter description';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 10.0,
          ),
          DropdownButtonFormField(
            items: const [
              DropdownMenuItem(
                  value: ExpenseCategory.food , child: Text('Food')),
              DropdownMenuItem(
                  value: ExpenseCategory.transport, child: Text('Transport')),
              DropdownMenuItem(
                  value: ExpenseCategory.entertainment,
                  child: Text('Entertainment')),
              DropdownMenuItem(
                  value: ExpenseCategory.health, child: Text('Health')),
              DropdownMenuItem(
                  value: ExpenseCategory.education, child: Text('Education')),
              DropdownMenuItem(value: ExpenseCategory.other, child: Text('Other')),
            ],
            onChanged: (value) {
              setState(() {
                category = value.toString();
              });
            },
            decoration: InputDecoration(
              labelText: 'Category',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            validator: (value) =>
                value == null ? 'Please select a category' : null,
          ),
          const SizedBox(
            height: 25.0,
          ),
            ETButton(text: 'Add Expense', onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  try {
                    await expenseBloc.addExpense(ExpenseModel(
                      amount: amount,
                      description: description,
                      category: category,
                      date: date,
                    ));
                    Navigator.pop(context);
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(e.toString()),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }

              }, variant: ETButtonVariant.primary),
        ],
      )
    ));
  }
}
