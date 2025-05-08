import 'package:template_flutter_provider/data/entities/budget.dart';
import 'package:template_flutter_provider/data/entities/category.dart';
import 'package:template_flutter_provider/data/services/budget_service.dart';

class BudgetRepository {
  final BudgetService budgetService;

  BudgetRepository(this.budgetService);

  Future<void> addBudget({
    required double amount,
    required double spent,
    required DateTime startDate,
    required DateTime endDate,
    required double goalAmount,
    required Category category,
  }) async {
    final budget = Budget(amount: amount, spent: spent, startDate: startDate, endDate: endDate, goalAmount: goalAmount);
    await budgetService.addBudget(budget);
  }

  List<Budget> getAllBudgets() {
    return budgetService.getAllBudgets();
  }

  Budget? getBudgetById(int id) {
    return budgetService.getBudgetById(id);
  }

  Future<void> updateBudget(Budget budget) async {
    await budgetService.updateBudget(budget);
  }

  Future<void> deleteBudget(int id) async {
    await budgetService.deleteBudget(id);
  }
}
