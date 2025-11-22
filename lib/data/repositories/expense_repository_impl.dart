// lib/data/repositories/expense_repository_impl.dart
import 'package:proyectofinal/domain/entities/expense.dart';
import 'package:proyectofinal/domain/repositories/expense_repository.dart';
import 'package:proyectofinal/data/datasources/expense_local_datasource.dart';

class ExpenseRepositoryImpl implements ExpenseRepository {
  final ExpenseLocalDataSource dataSource;

  ExpenseRepositoryImpl(this.dataSource);

  @override
  Future<void> addExpense(Expense expense) async {
    await dataSource.saveExpense(expense);
  }

  @override
  Future<List<Expense>> getExpenses() async {
    return await dataSource.loadExpenses();
  }

  @override
  Future<void> deleteExpense(String id) async {
    await dataSource.deleteExpense(id);
  }
}
