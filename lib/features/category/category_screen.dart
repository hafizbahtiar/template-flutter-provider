import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:template_flutter_provider/data/objectbox/objectbox.dart';
import 'package:template_flutter_provider/data/repositories/category_repository.dart';
import 'package:template_flutter_provider/data/services/category_service.dart';

import 'category_provider.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final objectBox = context.read<ObjectBox>();

    return ChangeNotifierProvider(
      create: (_) => CategoryProvider(categoryRepository: CategoryRepository(CategoryService(objectBox.store))),
      child: Consumer<CategoryProvider>(
        builder: (context, categoryProvider, _) {
          return Scaffold(
            appBar: AppBar(title: Text('Categories')),
            body: Consumer<CategoryProvider>(
              builder: (context, categoryProvider, _) {
                return ListView.builder(
                  itemCount: categoryProvider.categories.length,
                  itemBuilder: (context, index) {
                    final category = categoryProvider.categories[index];
                    return ListTile(
                      title: Text(category.name),
                      subtitle: Text(category.description ?? 'No Description'),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => categoryProvider.deleteCategory(category.id),
                      ),
                    );
                  },
                );
              },
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => _showAddCategoryDialog(context),
              child: Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }

  void _showAddCategoryDialog(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context, listen: false);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Category'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Name'),
                onChanged: (value) {
                  // store name input
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Description'),
                onChanged: (value) {
                  // store description input
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                // add category
                categoryProvider.addCategory('Sample Name', true);
                Navigator.pop(context);
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
