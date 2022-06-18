import 'package:flutter/material.dart';

import '../models/dish.dart';
import '../models/user.dart';
import 'locale_extensions.dart';

extension UserIterableExtensions on Iterable<User> {
  Map<String, User> toMap() =>
      <String, User>{for (final User user in this) user.name: user};
}

extension LocaleIterableExtensions on Iterable<Locale> {
  Map<String, Locale> toMap() => <String, Locale>{
        for (final Locale locale in this) locale.description: locale
      };
}

extension DishIterableExtensions on Iterable<Dish> {
  Iterable<Dish> get salads => where((Dish dish) => dish.isSalad);

  Iterable<Dish> get soups => where((Dish dish) => dish.isSoup);

  Iterable<Dish> get roasts => where((Dish dish) => dish.isRoast);

  Iterable<Dish> get garnishes => where((Dish dish) => dish.isGarnish);

  Iterable<Dish> select(Iterable<int> ids) {
    final List<Dish> result = List<Dish>.from(this);
    for (final int id in ids) {
      final Dish dish = result.firstWhere((Dish dish) => dish.id == id);
      if (dish != null) {
        dish.increment();
      }
    }

    return result;
  }

  Iterable<Dish> get selected => where((Dish dish) => dish.isSelected);

  Iterable<int> get ids => map((Dish dish) => dish.id);

  int get totalPrice =>
      fold(0, (int sum, Dish dish) => sum + dish.price * dish.count);
}
