// lib/main.dart
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'core/app_theme.dart';
import 'data/datasources/expense_local_datasource.dart';
import 'data/repositories/expense_repository_impl.dart';
import 'domain/usecases/add_expense.dart';
import 'domain/usecases/get_expenses.dart';
import 'presentation/controllers/expense_provider.dart';
import 'presentation/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  final box = await Hive.openBox("expenses");

  final dataSource = ExpenseLocalDataSource(box);
  final repository = ExpenseRepositoryImpl(dataSource);

  final addExpenseUseCase = AddExpense(repository);
  final getExpensesUseCase = GetExpenses(repository);

  runApp(MyApp(
    addExpenseUseCase: addExpenseUseCase,
    getExpensesUseCase: getExpensesUseCase,
  ));
}

class MyApp extends StatelessWidget {
  final AddExpense addExpenseUseCase;
  final GetExpenses getExpensesUseCase;

  const MyApp({
    super.key,
    required this.addExpenseUseCase,
    required this.getExpensesUseCase,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ExpenseProvider(
            addExpenseUseCase: addExpenseUseCase,
            getExpensesUseCase: getExpensesUseCase,
          )..loadExpenses(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Gastos Personales - Neon',
        theme: AppTheme.darkNeon,   // <-- FIX
        home: const HomePage(),
      ),
    );
  }
}
