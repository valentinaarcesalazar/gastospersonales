// lib/data/datasources/expense_local_datasource.dart
import 'package:hive/hive.dart';
import 'package:proyectofinal/domain/entities/expense.dart';

class ExpenseLocalDataSource {
  final Box _box;

  ExpenseLocalDataSource(this._box);

  Future<void> saveExpense(Expense expense) async {
    await _box.put(expense.id, {
      "id": expense.id,
      "title": expense.title,
      "amount": expense.amount,
      "date": expense.date.toIso8601String(),
      "category": expense.category,
    });
  }

  Future<List<Expense>> loadExpenses() async {
    final data = _box.values.toList();
    return data.map((e) {
      return Expense(
        id: e["id"],
        title: e["title"],
        amount: (e["amount"] is int) ? (e["amount"] as int).toDouble() : (e["amount"] as double),
        date: DateTime.parse(e["date"]),
        category: e["category"],
      );
    }).toList();
  }

  Future<void> deleteExpense(String id) async {
    await _box.delete(id);
  }
}
