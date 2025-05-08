import 'package:template_flutter_provider/data/entities/category.dart';
import 'package:template_flutter_provider/data/services/category_service.dart';

class CategoryRepository {
  final CategoryService categoryService;

  CategoryRepository(this.categoryService);

  Future<void> addCategory(String name, bool isIncome, {String? description, Category? parentCategory}) async {
    final category = Category(name: name, isIncome: isIncome, description: description, parentCategory: parentCategory);
    await categoryService.addCategory(category.name, category.isIncome);
  }

  List<Category> getAllCategories() {
    return categoryService.getAllCategories();
  }

  Category? getCategoryById(int id) {
    return categoryService.getCategoryById(id);
  }

  Future<void> updateCategory(Category category) async {
    await categoryService.updateCategory(category);
  }

  Future<void> deleteCategory(int id) async {
    await categoryService.deleteCategory(id);
  }
}
