import 'dish.dart';

class DishSet {
  DishSet({this.salad, this.soup, this.roast, this.garnish});

// ignore_for_file: argument_type_not_assignable, avoid_as
  factory DishSet.fromJson(Map<String, dynamic> json) => json == null
      ? null
      : DishSet(
          salad: Dish.fromJson(json['salad']),
          soup: Dish.fromJson(json['soup']),
          roast: Dish.fromJson(json['roast']),
          garnish: Dish.fromJson(json['garnish']),
        );

  final Dish salad;
  final Dish soup;
  final Dish roast;
  final Dish garnish;

  Iterable<Dish> get dishes => <Dish>[
        if (salad != null) salad,
        if (soup != null) soup,
        if (roast != null) roast,
        if (garnish != null) garnish,
      ];

  static Iterable<Dish> getDishes(DishSet dishSet) => dishSet.dishes;
}
