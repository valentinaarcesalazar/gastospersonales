// lib/presentation/pages/add_expense_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../../core/app_theme.dart';
import '../../domain/entities/expense.dart';
import '../controllers/expense_provider.dart';

class AddExpensePage extends StatefulWidget {
  const AddExpensePage({super.key});

  @override
  State<AddExpensePage> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  final _formKey = GlobalKey<FormState>();
  final _titleCtrl = TextEditingController();
  final _amountCtrl = TextEditingController();
  String _category = "General";
  DateTime _selectedDate = DateTime.now();

  @override
  void dispose() {
    _titleCtrl.dispose();
    _amountCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final d = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      builder: (ctx, child) => Theme(
        data: Theme.of(context).copyWith(
          dialogTheme: const DialogThemeData(
            backgroundColor: AppColors.panel,
          ),
        ),
        child: child!,
      ),
    );
    if (d != null) setState(() => _selectedDate = d);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ExpenseProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: const Text("Agregar Gasto")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleCtrl,
                style: const TextStyle(color: AppColors.text),
                decoration: InputDecoration(
                  labelText: "Descripción",
                  labelStyle: const TextStyle(color: AppColors.muted),
                  filled: true,
                  fillColor: AppColors.panel,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (v) =>
                (v == null || v.isEmpty) ? "Ingrese descripción" : null,
              ),

              const SizedBox(height: 12),

              TextFormField(
                controller: _amountCtrl,
                style: const TextStyle(color: AppColors.text),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Monto",
                  labelStyle: const TextStyle(color: AppColors.muted),
                  filled: true,
                  fillColor: AppColors.panel,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (v) {
                  if (v == null || v.isEmpty) return "Ingrese monto";
                  if (double.tryParse(v) == null) return "Monto inválido";
                  return null;
                },
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      initialValue: _category,
                      dropdownColor: AppColors.panel,
                      items: ["General", "Comida", "Transporte", "Hogar", "Ocio"]
                          .map((c) =>
                          DropdownMenuItem(
                            value: c,
                            child: Text(c, style: const TextStyle(color: AppColors.text)),
                          ))
                          .toList(),
                      onChanged: (v) => setState(() => _category = v!),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColors.panel,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  ElevatedButton.icon(
                    onPressed: _pickDate,
                    icon: const Icon(Icons.calendar_today),
                    label: Text("${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}"),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              ElevatedButton(
                onPressed: () async {
                  if (!_formKey.currentState!.validate()) return;

                  final expense = Expense(
                    id: const Uuid().v4(),
                    title: _titleCtrl.text,
                    amount: double.parse(_amountCtrl.text),
                    date: _selectedDate,
                    category: _category,
                  );

                  await provider.addNewExpense(expense);
                  if (mounted) Navigator.pop(context);
                },
                child: const Text("Guardar gasto"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
