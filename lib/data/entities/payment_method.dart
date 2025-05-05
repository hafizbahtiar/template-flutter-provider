import 'package:objectbox/objectbox.dart';

@Entity()
class PaymentMethod {
  @Id()
  int id = 0;

  String name; // e.g., "Cash", "Credit Card", "Bank Transfer"
  String description; // Optional description of the payment method

  PaymentMethod({required this.name, required this.description});
}
