import 'package:hive/hive.dart';
part 'recipe.g.dart';

@HiveType(typeId : 1)
class Recipe {
      Recipe({ this.name, this.description, this.category, this.ingredients});

  @HiveField(0)
  String? name;

  @HiveField(1)
  String? description;

  @HiveField(2)
  String? category;

  @HiveField(3)
  List<Ingredient>? ingredients;
}

@HiveType(typeId : 2)
class Ingredient {
      Ingredient({required this.name, required this.amount, required this.unit});
@HiveField(0)
  String name;

@HiveField(1)
  double amount;

@HiveField(2)
  String unit;
}