import 'package:template_flutter_provider/data/entities/category.dart';

import '../objectbox/objectbox.g.dart';

class CategoryRepository {
  final Store store;

  CategoryRepository(this.store);

  // Add a new category
  Future<void> addCategory(Category category) async {
    final box = store.box<Category>();
    box.put(category);
  }

  // Get all categories
  List<Category> getAllCategories() {
    final box = store.box<Category>();
    return box.getAll();
  }

  // Get category by ID
  Category? getCategoryById(int id) {
    final box = store.box<Category>();
    return box.get(id);
  }

  // Update category
  Future<void> updateCategory(Category category) async {
    final box = store.box<Category>();
    box.put(category);
  }

  // Delete category
  Future<void> deleteCategory(int id) async {
    final box = store.box<Category>();
    box.remove(id);
  }
}
