import 'package:template_flutter_provider/data/entities/transaction.dart';

import '../objectbox/objectbox.g.dart';

class TransactionRepository {
  final Store store;

  TransactionRepository(this.store);

  // Add a new transaction
  Future<void> addTransaction(Transaction transaction) async {
    final box = store.box<Transaction>();
    box.put(transaction);
  }

  // Get all transactions
  List<Transaction> getAllTransactions() {
    final box = store.box<Transaction>();
    return box.getAll();
  }

  // Get transactions by category
  List<Transaction> getTransactionsByCategory(int categoryId) {
    final box = store.box<Transaction>();
    return box.query(Transaction_.categoryId.equals(categoryId)).build().find();
  }

  // Get transaction by ID
  Transaction? getTransactionById(int id) {
    final box = store.box<Transaction>();
    return box.get(id);
  }

  // Update a transaction
  Future<void> updateTransaction(Transaction transaction) async {
    final box = store.box<Transaction>();
    box.put(transaction);
  }

  // Delete a transaction
  Future<void> deleteTransaction(int id) async {
    final box = store.box<Transaction>();
    box.remove(id);
  }
}
