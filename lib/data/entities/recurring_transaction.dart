import 'package:objectbox/objectbox.dart';
import 'transaction.dart';

@Entity()
class RecurringTransaction {
  @Id()
  int id = 0;

  final transactionId = ToOne<Transaction>(); // Link to original transaction

  DateTime nextPaymentDate; // When will the next payment be due?

  // Constructor (without transaction parameter)
  RecurringTransaction({required this.nextPaymentDate});
}