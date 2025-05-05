import 'package:objectbox/objectbox.dart';

@Entity()
class Category {
  @Id()
  int id = 0;

  late final String name; // e.g., "Food", "Entertainment"
  late final bool isIncome; // true for income, false for expense

  String? description; // Optional description

  final parentCategory = ToOne<Category>(); // Optional for subcategories

  Category({required this.name, required this.isIncome, this.description, Category? parentCategory}) {
    if (parentCategory != null) {
      this.parentCategory.target = parentCategory;
    }
  }
}
