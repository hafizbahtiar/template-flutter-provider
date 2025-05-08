import 'package:template_flutter_provider/data/entities/budget.dart';
import 'package:objectbox/objectbox.dart';

class BudgetService {
  final Store store;

  BudgetService(this.store);

  Future<void> addBudget(Budget budget) async {
    store.box<Budget>().put(budget);
  }

  List<Budget> getAllBudgets() {
    return store.box<Budget>().getAll();
  }

  Budget? getBudgetById(int id) {
    return store.box<Budget>().get(id);
  }

  Future<void> updateBudget(Budget budget) async {
    store.box<Budget>().put(budget);
  }

  Future<void> deleteBudget(int id) async {
    store.box<Budget>().remove(id);
  }
}
