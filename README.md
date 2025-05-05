# 📱 Flutter Provider Template

A comprehensive Flutter starter template implementing clean architecture principles with Provider for state management and ObjectBox for local NoSQL persistence.

## ✨ Features

- **Clean Architecture**: Separation of UI, state, business logic, and data layers
- **State Management**: Using Provider for reactive UI updates 
- **Local Persistence**: ObjectBox NoSQL database for offline-first capability
- **CRUD Operations**: Full implementation for all entities
- **Modular Design**: Feature-based organization for scalability

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (latest stable version)
- Dart SDK
- Android Studio / VS Code

### Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/yourusername/template_flutter_provider.git
   ```

2. Navigate to the project directory:
   ```bash
   cd template_flutter_provider
   ```

3. Get dependencies:
   ```bash
   flutter pub get
   ```

4. Run the app:
   ```bash
   flutter run
   ```

## 🧱 Architecture Overview

```
lib/
├── data/
│   ├── entities/         # ObjectBox @Entity models
│   ├── repositories/     # Interfaces to ObjectBox data access
│   └── objectbox/        # ObjectBox store setup
├── features/
│   ├── home/             # Example feature module
│   └── ...               # Additional features
├── services/             # Business logic services
├── providers/            # State management with Provider
└── main.dart             # Entry point
```

## 🗃️ Core Components

### Entity Models

All models use ObjectBox annotations for database integration:

```dart
@Entity()
class Category {
  @Id()
  int id = 0;

  String name;
  bool isIncome;

  @Property(type: PropertyType.string)
  String? description;

  final parentCategory = ToOne<Category>();

  Category({
    required this.name,
    required this.isIncome,
    this.description,
    Category? parentCategory,
  }) {
    if (parentCategory != null) {
      this.parentCategory.target = parentCategory;
    }
  }
}
```

### Repositories

Each entity has a repository for database operations:

```dart
class UserRepository {
  final Store store;

  UserRepository(this.store);

  Future<void> addUser(User user) async => store.box<User>().put(user);
  List<User> getAllUsers() => store.box<User>().getAll();
  User? getUserById(int id) => store.box<User>().get(id);
  Future<void> deleteUser(int id) async => store.box<User>().remove(id);
}
```

### Services

Services encapsulate business logic and interact with repositories:

```dart
class UserService {
  final UserRepository userRepository;

  UserService(this.userRepository);

  Future<void> addUser(String name, String email) async {
    final user = User(name: name, email: email, currency: 'USD', language: 'en');
    await userRepository.addUser(user);
  }

  List<User> getAllUsers() => userRepository.getAllUsers();
  User? getUserById(int id) => userRepository.getUserById(id);
  Future<void> deleteUser(int id) async => userRepository.deleteUser(id);
}
```

### Providers

Providers manage state and update the UI:

```dart
class UserProvider extends ChangeNotifier {
  final UserService userService;

  List<User> _users = [];
  List<User> get users => _users;

  UserProvider({required this.userService}) {
    loadUsers();
  }

  void addUser(String name, String email) async {
    await userService.addUser(name, email);
    loadUsers();
  }

  void loadUsers() {
    _users = userService.getAllUsers();
    notifyListeners();
  }
}
```

## 📊 Implemented Features

| Feature | Status |
|---------|--------|
| User CRUD | ✅ Complete |
| Category Management | ✅ Complete |
| Transaction Logging | ✅ Complete |
| Recurring Transactions | ✅ Complete |
| Budget Management | ✅ Complete |
| Payment Methods | ✅ Complete |
| Sync System | 🔜 Planned |

## 🧪 Testing

Unit tests for repositories and services coming soon.

## 📚 Resources

* [Flutter Documentation](https://docs.flutter.dev/)
* [Provider Package](https://pub.dev/packages/provider)
* [ObjectBox Documentation](https://docs.objectbox.io/getting-started)

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the LICENSE file for details.