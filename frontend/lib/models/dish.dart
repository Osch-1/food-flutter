import 'dart:math';

class Dish {
  Dish({
    this.id,
    this.name,
    this.price,
    this.description,
    this.type,
    this.weight,
    this.imagePath,
  });

// ignore_for_file: argument_type_not_assignable, avoid_as
  factory Dish.fromJson(Map<String, dynamic> json) => json == null
      ? null
      : Dish(
          id: json['id'],
          name: json['name'],
          price: (json['price'] as double).toInt(),
          description: json['description'],
          type: json['type'],
          weight: (json['weight'] as double).toInt(),
          imagePath: json['imagePath'],
        );

  final int id;
  final String name;
  final int price;
  final String description;
  final int type;
  final int weight;
  final String imagePath;

  int _count = 0;

  int get count => _count;

  bool get isSalad => type == 0;

  bool get isSoup => type == 1;

  bool get isRoast => type == 3;

  bool get isGarnish => type == 2;

  bool get isSelected => _count > 0;

  void increment() => changeCount(1);

  void decrement() => changeCount(-1);

  void changeCount(int delta) => _count = max(_count + delta, 0);
}
