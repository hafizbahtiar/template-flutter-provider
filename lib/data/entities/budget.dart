import 'package:objectbox/objectbox.dart';
import 'category.dart';

@Entity()
class Budget {
  @Id()
  int id = 0;

  final categoryId = ToOne<Category>(); // Link to Category (e.g., "Food")
  double amount; // Budgeted amount (e.g., $500)
  double spent; // Amount already spent in this category

  DateTime startDate;
  DateTime endDate;

  double goalAmount; // Set a goal (e.g., save $2000 for a vacation)

  // Constructor (no category parameter)
  Budget({
    required this.amount,
    required this.spent,
    required this.startDate,
    required this.endDate,
    required this.goalAmount,
  });

  // Method to set the category after the object is created
  void setCategory(Category category) {
    categoryId.target = category;
  }
}
