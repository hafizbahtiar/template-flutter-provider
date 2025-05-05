import 'package:objectbox/objectbox.dart';

import 'category.dart';
import 'payment_method.dart';
import 'user.dart';

@Entity()
class Transaction {
  @Id()
  int id = 0;

  @Property(type: PropertyType.date)
  DateTime date;

  double amount; // e.g., 100.50
  String description; // Description of the transaction (e.g., "Bought groceries")

  final categoryId = ToOne<Category>(); // Link to Category (Expense or Income)
  final paymentMethodId = ToOne<PaymentMethod>(); // Link to Payment Method
  final userId = ToOne<User>(); // Link to User (who created this transaction)

  bool isRecurring; // true for recurring transactions
  String? recurrenceInterval; // e.g., "Monthly", "Weekly"

  String status; // e.g., "Pending", "Completed", "Failed"

  // Constructor (no category, paymentMethod, or user parameter)
  Transaction({
    required this.date,
    required this.amount,
    required this.description,
    this.isRecurring = false,
    this.recurrenceInterval,
    this.status = 'Pending',
  });

  // Set the category after the object is created
  void setCategory(Category category) {
    categoryId.target = category;
  }

  // Set the payment method after the object is created
  void setPaymentMethod(PaymentMethod paymentMethod) {
    paymentMethodId.target = paymentMethod;
  }

  // Set the user after the object is created
  void setUser(User user) {
    userId.target = user;
  }
}
