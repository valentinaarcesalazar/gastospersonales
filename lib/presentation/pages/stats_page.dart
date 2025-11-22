// lib/presentation/pages/stats_page.dart
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/app_theme.dart';
import '../controllers/expense_provider.dart';

class StatsPage extends StatelessWidget {
  const StatsPage({super.key});

  List<PieChartSectionData> _makeSections(Map<String, double> data) {
    final colors = [AppColors.neonFuchsia, AppColors.neonBlue, AppColors.accent, AppColors.muted];
    int idx = 0;
    return data.entries.map((e) {
      final value = e.value;
      final color = colors[idx % colors.length];
      idx++;
      return PieChartSectionData(
        value: value,
        color: color,
        title: "${(value).toStringAsFixed(0)}",
        radius: 60,
        titleStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ExpenseProvider>(context);
    final expenses = provider.expenses;

    final total = expenses.fold(0.0, (s, e) => s + e.amount);
    final Map<String, double> byCategory = {};
    for (var e in expenses) {
      byCategory[e.category] = (byCategory[e.category] ?? 0) + e.amount;
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Estadísticas")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              color: AppColors.panel,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      const Text("Total gastado", style: TextStyle(color: AppColors.muted)),
                      const SizedBox(height: 8),
                      Text("\$${total.toStringAsFixed(0)}", style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.neonFuchsia)),
                    ]),
                    const Spacer(),
                    SizedBox(
                      width: 160,
                      height: 160,
                      child: PieChart(
                        PieChartData(
                          sections: _makeSections(byCategory.isEmpty ? {"Sin": 1} : byCategory),
                          centerSpaceRadius: 24,
                          sectionsSpace: 6,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: byCategory.entries.map((e) {
                  return ListTile(
                    tileColor: AppColors.panel,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    leading: Container(width: 12, height: 12, decoration: BoxDecoration(color: AppColors.neonFuchsia, borderRadius: BorderRadius.circular(4))),
                    title: Text(e.key),
                    trailing: Text("\$${e.value.toStringAsFixed(0)}"),
                  );
                }).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
