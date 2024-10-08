
import 'package:date_time_format/date_time_format.dart';
import 'package:expense_tracker/blocs/expense_bloc.dart';
import 'package:expense_tracker/models/expense_model.dart';
import 'package:expense_tracker/widgets/atoms/button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ExpenseTemplate extends StatefulWidget {
  const ExpenseTemplate({super.key});

  @override
  State<ExpenseTemplate> createState() => _ExpenseTemplateState();
}

class _ExpenseTemplateState extends State<ExpenseTemplate> {
  String? _activeFilter = '';

  Icon _generateCategoryIcon(String category) {
    switch (category) {
      case 'ExpenseCategory.food':
        return const Icon(Icons.fastfood, color: Colors.orange);
      case 'ExpenseCategory.transport':
        return const Icon(Icons.directions_bus, color: Colors.blue);
      case 'ExpenseCategory.shopping':
        return const Icon(Icons.shopping_cart, color: Colors.green);
      case 'ExpenseCategory.entertainment':
        return const Icon(Icons.movie, color: Colors.purple);
      case 'ExpenseCategory.health':
        return const Icon(Icons.local_hospital, color: Colors.red);
      case 'ExpenseCategory.bills':
        return const Icon(Icons.receipt, color: Colors.yellow);
      case 'ExpenseCategory.others':
        return const Icon(Icons.attach_money, color: Colors.grey);
      default:
        return const Icon(Icons.attach_money, color: Colors.grey);
    }
  }

  String _formatDate(String date) {
    return DateTimeFormat.format(DateTime.parse(date), format: 'H:i A');
  }

  String _formatAmount(int amount) {
    return NumberFormat.simpleCurrency(
            locale: 'id_ID', decimalDigits: 0, name: 'Rp ')
        .format(amount);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              height: 60,
              child: ListView(scrollDirection: Axis.horizontal, children: [
                Center(
                    child: ETButton(
                        text: AppLocalizations.of(context)?.today ?? '',
                        onPressed: () {
                          setState(() {
                            _activeFilter = 'today';
                          });
                        },
                        variant: _activeFilter == 'today'
                            ? ETButtonVariant.primary
                            : ETButtonVariant.secondary,
                        size: ETButtonSize.fit)),
                const SizedBox(width: 4),
                Center(
                    child: ETButton(
                        text: 'This Week',
                        onPressed: () {
                          setState(() {
                            _activeFilter = 'week';
                          });
                        },
                        variant: _activeFilter == 'week'
                            ? ETButtonVariant.primary
                            : ETButtonVariant.secondary,
                        size: ETButtonSize.fit)),
                const SizedBox(width: 4),
                Center(
                    child: ETButton(
                        text: 'This Month',
                        onPressed: () {
                          setState(() {
                            _activeFilter = 'month';
                          });
                        },
                        variant: _activeFilter == 'month'
                            ? ETButtonVariant.primary
                            : ETButtonVariant.secondary,
                        size: ETButtonSize.fit)),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.calendar_month, size: 32), color: Colors.grey.shade900),
              ]),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              width: double.infinity,
              child: Card(
                elevation: 0,
                color: Colors.grey.shade900,
                child: StreamBuilder<int>(
                  stream: expenseBloc.totalSumExpenses,
                  builder: (context, AsyncSnapshot<int> snapshot) {
                    if (snapshot.hasData) {
                      return Padding(
                          padding: const EdgeInsets.only(top: 16, bottom: 16),
                          child: Column(
                            children: [
                              const Text(
                                'Spend so far',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: Colors.white),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                _formatAmount(snapshot.data!),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                    color: Colors.white),
                              )
                            ],
                          ));
                    } else if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    }
                    return const CircularProgressIndicator();
                  },
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder<List<ExpenseModel>>(
                stream: expenseBloc.allExpenses,
                builder: (context, AsyncSnapshot<List<ExpenseModel>> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Card(
                            elevation: 0,
                            color: Colors.white,
                            child: ListTile(
                              leading: _generateCategoryIcon(
                                  snapshot.data![index].category.toString()),
                              title: Text(
                                snapshot.data![index].description.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF333333)),
                              ),
                              subtitle: Text(
                                _formatDate(
                                    snapshot.data![index].date.toString()),
                                style: const TextStyle(fontSize: 12, color: Color.fromARGB(255, 66, 66, 66)),
                              ),
                              trailing: Text(
                                _formatAmount(snapshot.data![index].amount!),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF333333)),
                              ),
                            ));
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  } else if (snapshot.data == null) {
                    return const Center(
                      child: Text(
                        "Enter your first expense",
                      ),
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            )
          ],
        ),
      );
  }
}