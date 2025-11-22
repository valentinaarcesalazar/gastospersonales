import 'package:flutter_test/flutter_test.dart';
import 'package:proyectofinal/domain/entities/expense.dart';
import 'package:proyectofinal/domain/usecases/get_category_totals.dart';

void main() {
  test('Debe calcular montos por categoría correctamente', () {
    final usecase = GetCategoryTotals();

    final expenses = [
      Expense(id: "1", title: "Bus", amount: 5000, date: DateTime.now(), category: "Transporte"),
      Expense(id: "2", title: "Comida", amount: 20000, date: DateTime.now(), category: "Comida"),
      Expense(id: "3", title: "Uber", amount: 8000, date: DateTime.now(), category: "Transporte"),
    ];

    final totals = usecase(expenses);

    expect(totals["Transporte"], 13000);
    expect(totals["Comida"], 20000);
  });
}
