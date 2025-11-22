// lib/presentation/controllers/expense_provider.dart
import 'package:flutter/material.dart';
import '../../domain/entities/expense.dart';
import '../../domain/usecases/add_expense.dart';
import '../../domain/usecases/get_expenses.dart';

class ExpenseProvider extends ChangeNotifier {
  final AddExpense addExpenseUseCase;
  final GetExpenses getExpensesUseCase;

  ExpenseProvider({
    required this.addExpenseUseCase,
    required this.getExpensesUseCase,
  });

  List<Expense> expenses = [];
  List<Expense> filteredExpenses = [];

  Future<void> loadExpenses() async {
    expenses = await getExpensesUseCase();
    filteredExpenses = List.from(expenses);
    notifyListeners();
  }

  Future<void> addNewExpense(Expense expense) async {
    await addExpenseUseCase(expense);
    await loadExpenses();
  }

  void applyFilters({String? category, DateTime? date}) {
    filteredExpenses = expenses.where((e) {
      final matchCategory = category == null ? true : e.category == category;
      final matchDate = date == null
          ? true
          : (e.date.year == date.year &&
              e.date.month == date.month &&
              e.date.day == date.day);
      return matchCategory && matchDate;
    }).toList();
    notifyListeners();
  }

  void clearFilters() {
    filteredExpenses = List.from(expenses);
    notifyListeners();
  }
}
