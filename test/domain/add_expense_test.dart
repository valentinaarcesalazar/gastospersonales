import 'package:flutter_test/flutter_test.dart';
import 'package:proyectofinal/domain/entities/expense.dart';
import 'package:proyectofinal/domain/usecases/add_expense.dart';
import 'package:proyectofinal/domain/repositories/expense_repository.dart';

class FakeRepository implements ExpenseRepository {
  final List<Expense> saved = [];

  @override
  Future<List<Expense>> getExpenses() async => saved;

  @override
  Future<void> addExpense(Expense expense) async {
    saved.add(expense);
  }

  @override
  Future<void> deleteExpense(String id) async {
    saved.removeWhere((e) => e.id == id);
  }
}

void main() {
  test("Debe agregar un gasto correctamente", () async {
    final repo = FakeRepository();
    final usecase = AddExpense(repo);

    final expense = Expense(
      id: "1",
      title: "Prueba",
      amount: 10000,
      date: DateTime.now(),
      category: "Comida",
    );

    await usecase(expense);

    expect(repo.saved.length, 1);
    expect(repo.saved.first.title, "Prueba");
  });
}
