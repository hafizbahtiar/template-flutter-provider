import 'package:template_flutter_provider/data/entities/budget.dart';
import 'package:template_flutter_provider/data/entities/category.dart';
import 'package:template_flutter_provider/data/repositories/budget_repository.dart';

class BudgetService {
  final BudgetRepository repository;

  BudgetService(this.repository);

  Future<void> addBudget({
    required double amount,
    required double spent,
    required DateTime startDate,
    required DateTime endDate,
    required double goalAmount,
    required Category category,
  }) async {
    final budget = Budget(amount: amount, spent: spent, startDate: startDate, endDate: endDate, goalAmount: goalAmount);
    await repository.addBudget(budget);
  }

  List<Budget> getAllBudgets() {
    return repository.getAllBudgets();
  }

  Budget? getBudgetById(int id) {
    return repository.getBudgetById(id);
  }

  Future<void> updateBudget(Budget budget) async {
    await repository.updateBudget(budget);
  }

  Future<void> deleteBudget(int id) async {
    await repository.deleteBudget(id);
  }
}
