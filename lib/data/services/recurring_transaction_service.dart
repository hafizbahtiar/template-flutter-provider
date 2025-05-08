import 'package:template_flutter_provider/data/entities/recurring_transaction.dart';
import 'package:objectbox/objectbox.dart';

class RecurringTransactionService {
  final Store store;

  RecurringTransactionService(this.store);

  Future<void> addRecurringTransaction(RecurringTransaction recurringTransaction) async {
    final box = store.box<RecurringTransaction>();
    box.put(recurringTransaction);
  }

  List<RecurringTransaction> getAllRecurringTransactions() {
    final box = store.box<RecurringTransaction>();
    return box.getAll();
  }

  RecurringTransaction? getRecurringTransactionById(int id) {
    final box = store.box<RecurringTransaction>();
    return box.get(id);
  }

  Future<void> updateRecurringTransaction(RecurringTransaction transaction) async {
    final box = store.box<RecurringTransaction>();
    box.put(transaction);
  }

  Future<void> deleteRecurringTransaction(int id) async {
    final box = store.box<RecurringTransaction>();
    box.remove(id);
  }
}
