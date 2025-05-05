import 'package:template_flutter_provider/data/entities/recurring_transaction.dart';
import 'package:template_flutter_provider/data/entities/transaction.dart';
import 'package:template_flutter_provider/data/repositories/recurring_transaction_repository.dart';

class RecurringTransactionService {
  final RecurringTransactionRepository repository;

  RecurringTransactionService(this.repository);

  Future<void> addRecurringTransaction(Transaction transaction, DateTime nextDate) async {
    final recurring = RecurringTransaction(nextPaymentDate: nextDate);
    await repository.addRecurringTransaction(recurring);
  }

  List<RecurringTransaction> getAllRecurringTransactions() {
    return repository.getAllRecurringTransactions();
  }

  RecurringTransaction? getById(int id) {
    return repository.getRecurringTransactionById(id);
  }

  Future<void> updateRecurringTransaction(RecurringTransaction transaction) async {
    await repository.updateRecurringTransaction(transaction);
  }

  Future<void> deleteRecurringTransaction(int id) async {
    await repository.deleteRecurringTransaction(id);
  }
}
