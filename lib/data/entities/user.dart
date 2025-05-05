import 'package:objectbox/objectbox.dart';

@Entity()
class User {
  @Id()
  int id = 0;

  @Unique()
  String name;

  @Unique()
  String email;

  String currency; // e.g., USD, EUR, etc.

  String language; // e.g., en, es, fr

  @Property(type: PropertyType.date)
  DateTime createdAt;

  User({required this.name, required this.email, this.currency = 'MYR', this.language = 'ms', DateTime? createdAt})
    : createdAt = createdAt ?? DateTime.now();

  @override
  String toString() => 'User{id: $id, name: $name, createdAt: $createdAt}';
}
