import 'package:template_flutter_provider/data/entities/category.dart';
import 'package:template_flutter_provider/data/repositories/category_repository.dart';

class CategoryService {
  final CategoryRepository categoryRepository;

  CategoryService(this.categoryRepository);

  Future<void> addCategory(String name, bool isIncome, {String? description, Category? parentCategory}) async {
    final category = Category(name: name, isIncome: isIncome, description: description, parentCategory: parentCategory);
    await categoryRepository.addCategory(category);
  }

  List<Category> getAllCategories() {
    return categoryRepository.getAllCategories();
  }

  Category? getCategoryById(int id) {
    return categoryRepository.getCategoryById(id);
  }

  Future<void> updateCategory(Category category) async {
    await categoryRepository.updateCategory(category);
  }

  Future<void> deleteCategory(int id) async {
    await categoryRepository.deleteCategory(id);
  }
}
