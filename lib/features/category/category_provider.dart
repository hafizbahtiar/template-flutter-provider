import 'package:flutter/material.dart';
import 'package:template_flutter_provider/data/repositories/category_repository.dart';

import '../../data/entities/category.dart';

class CategoryProvider extends ChangeNotifier {
  final CategoryRepository categoryRepository;

  List<Category> _categories = [];
  List<Category> get categories => _categories;

  CategoryProvider({required this.categoryRepository}) {
    loadCategories();
  }

  void addCategory(String name, bool isIncome, {String? description, Category? parentCategory}) async {
    await categoryRepository.addCategory(name, isIncome, description: description, parentCategory: parentCategory);
    loadCategories();
  }

  void deleteCategory(int id) async {
    await categoryRepository.deleteCategory(id);
    loadCategories();
  }

  void loadCategories() {
    _categories = categoryRepository.getAllCategories();
    notifyListeners();
  }
}
