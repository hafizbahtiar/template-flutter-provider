import 'package:template_flutter_provider/data/entities/recurring_transaction.dart';
import 'package:template_flutter_provider/data/entities/transaction.dart';
import 'package:template_flutter_provider/data/services/recurring_transaction_service.dart';

class RecurringTransactionRepository {
  final RecurringTransactionService recurringTransactionService;

  RecurringTransactionRepository(this.recurringTransactionService);

  Future<void> addRecurringTransaction(Transaction transaction, DateTime nextDate) async {
    final recurring = RecurringTransaction(nextPaymentDate: nextDate);
    await recurringTransactionService.addRecurringTransaction(recurring);
  }

  List<RecurringTransaction> getAllRecurringTransactions() {
    return recurringTransactionService.getAllRecurringTransactions();
  }

  RecurringTransaction? getById(int id) {
    return recurringTransactionService.getRecurringTransactionById(id);
  }

  Future<void> updateRecurringTransaction(RecurringTransaction transaction) async {
    await recurringTransactionService.updateRecurringTransaction(transaction);
  }

  Future<void> deleteRecurringTransaction(int id) async {
    await recurringTransactionService.deleteRecurringTransaction(id);
  }
}
