import '../entities/expense.dart';

class GetCategoryTotals {
  Map<String, double> call(List<Expense> expenses) {
    Map<String, double> totals = {};

    for (var e in expenses) {
      totals[e.category] = (totals[e.category] ?? 0) + e.amount;
    }

    return totals;
  }
}
