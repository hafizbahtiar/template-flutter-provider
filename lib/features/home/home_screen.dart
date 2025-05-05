import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:template_flutter_provider/data/entities/user.dart';
import 'package:template_flutter_provider/data/objectbox/objectbox.dart';
import 'package:template_flutter_provider/data/repositories/user_repository.dart';
import 'package:template_flutter_provider/features/home/home_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final objectBox = context.read<ObjectBox>();

    return ChangeNotifierProvider(
      create: (BuildContext context) => UserProvider(userRepository: UserRepository(objectBox.store)),
      child: Consumer<UserProvider>(
        builder: (context, userProvider, _) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Home'),
              actions: [
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed:
                      () => userProvider.addUser(
                        'User ${DateTime.now().millisecondsSinceEpoch}',
                        '${DateTime.now().millisecondsSinceEpoch}@test.com',
                      ),
                ),
              ],
            ),
            body:
                userProvider.users.isEmpty
                    ? const Center(child: Text('No users available'))
                    : ListView.builder(
                      itemCount: userProvider.users.length,
                      itemBuilder: (context, index) {
                        final user = userProvider.users[index];
                        return ListTile(
                          title: Text(user.name),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [Text("ID: ${user.id}"), Text("Email: ${user.email}")],
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              _showDeleteDialog(context, user, userProvider);
                            },
                          ),
                        );
                      },
                    ),
          );
        },
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, User user, UserProvider userProvider) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: Text('Are you sure you want to delete ${user.name}?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                userProvider.deleteUser(user.id);
                Navigator.of(context).pop();
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
