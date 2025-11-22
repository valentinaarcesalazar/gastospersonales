// lib/presentation/pages/home_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animations/animations.dart';

import '../controllers/expense_provider.dart';
import 'add_expense_page.dart';
import 'stats_page.dart';
import 'filter_page.dart';
import '../../core/app_theme.dart';
import '../../domain/entities/expense.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Widget _buildCard(BuildContext context, Expense e) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.panel.withAlpha((0.9 * 255).round()),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.neonFuchsia.withAlpha((0.12 * 255).round()),
            blurRadius: 12,
            spreadRadius: 1,
            offset: const Offset(0, 6),
          ),
          BoxShadow(
            color: AppColors.neonBlue.withAlpha((0.03 * 255).round()),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: AppColors.neonFuchsia.withAlpha((0.06 * 255).round())),
      ),
      child: Row(
        children: [
          // icon circle with glow
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.neonFuchsia, AppColors.neonBlue],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: AppColors.neonFuchsia.withAlpha((0.25 * 255).round()),
                  blurRadius: 12,
                  spreadRadius: 2,
                )
              ],
            ),
            child: Center(
              child: Text(
                e.title.isNotEmpty ? e.title[0].toUpperCase() : "G",
                style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  e.title,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 6),
                Text(
                  "${e.category} • ${e.date.day}/${e.date.month}/${e.date.year}",
                  style: const TextStyle(color: AppColors.muted, fontSize: 12),
                ),
              ],
            ),
          ),
          Text(
            "\$${e.amount.toStringAsFixed(0)}",
            style: const TextStyle(fontWeight: FontWeight.w700, color: AppColors.neonFuchsia),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gastos Personales'),
        actions: [
          IconButton(
            icon: const Icon(Icons.bar_chart),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const StatsPage()),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.filter_alt),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const FilterPage()),
            ),
          ),
        ],
      ),
      body: Consumer<ExpenseProvider>(
        builder: (context, provider, child) {
          final list = provider.filteredExpenses;
          if (list.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.sentiment_dissatisfied, size: 64, color: AppColors.muted),
                    const SizedBox(height: 12),
                    const Text(
                      "No hay gastos registrados",
                      style: TextStyle(color: AppColors.muted),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.add),
                      label: const Text("Agregar primer gasto"),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const AddExpensePage()),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.only(top: 12, bottom: 90),
            itemCount: list.length,
            itemBuilder: (context, i) {
              final e = list[i];
              return OpenContainer(
                closedElevation: 0,
                openElevation: 6,
                transitionType: ContainerTransitionType.fade,
                closedBuilder: (ctx, open) => GestureDetector(
                  onTap: open,
                  child: _buildCard(context, e),
                ),
                openBuilder: (ctx, close) {
                  return Scaffold(
                    appBar: AppBar(title: Text(e.title)),
                    body: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            e.title,
                            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text("Categoría: ${e.category}"),
                          const SizedBox(height: 8),
                          Text("Fecha: ${e.date.toLocal()}"),
                          const SizedBox(height: 16),
                          Text("Monto: \$${e.amount}"),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const AddExpensePage()),
        ),
        child: const Icon(Icons.add),
        backgroundColor: AppColors.neonFuchsia,
      ),
    );
  }
}
