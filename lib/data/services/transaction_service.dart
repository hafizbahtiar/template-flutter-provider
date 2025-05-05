import 'package:template_flutter_provider/data/entities/transaction.dart';
import 'package:template_flutter_provider/data/entities/category.dart';
import 'package:template_flutter_provider/data/entities/payment_method.dart';
import 'package:template_flutter_provider/data/entities/user.dart';
import 'package:template_flutter_provider/data/repositories/transaction_repository.dart';

class TransactionService {
  final TransactionRepository transactionRepository;

  TransactionService(this.transactionRepository);

  Future<void> addTransaction({
    required DateTime date,
    required double amount,
    required String description,
    required Category category,
    required PaymentMethod paymentMethod,
    required User user,
    bool isRecurring = false,
    String? recurrenceInterval,
    String status = "Pending",
  }) async {
    final transaction = Transaction(
      date: date,
      amount: amount,
      isRecurring: isRecurring,
      recurrenceInterval: recurrenceInterval,
      status: status,
      description: description,
    );

    await transactionRepository.addTransaction(transaction);
  }

  List<Transaction> getAllTransactions() {
    return transactionRepository.getAllTransactions();
  }

  Transaction? getTransactionById(int id) {
    return transactionRepository.getTransactionById(id);
  }

  Future<void> updateTransaction(Transaction transaction) async {
    await transactionRepository.updateTransaction(transaction);
  }

  Future<void> deleteTransaction(int id) async {
    await transactionRepository.deleteTransaction(id);
  }
}
