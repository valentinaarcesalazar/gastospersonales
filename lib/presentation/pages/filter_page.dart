// lib/presentation/pages/filter_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/expense_provider.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  String? selectedCategory;
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ExpenseProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Filtrar Gastos")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              initialValue: selectedCategory,
              hint: const Text("Seleccionar categoría"),
              items: ["General", "Comida", "Transporte", "Hogar", "Ocio"]
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() => selectedCategory = value);
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2020),
                  lastDate: DateTime.now(),
                );
                setState(() => selectedDate = pickedDate);
              },
              child: Text(
                selectedDate == null
                    ? "Seleccionar fecha"
                    : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                provider.applyFilters(
                  category: selectedCategory,
                  date: selectedDate,
                );
                Navigator.pop(context);
              },
              child: const Text("Aplicar Filtro"),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                provider.clearFilters();
                Navigator.pop(context);
              },
              child: const Text("Quitar Filtros"),
            ),
          ],
        ),
      ),
    );
  }
}
