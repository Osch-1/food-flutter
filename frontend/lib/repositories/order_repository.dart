import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../core/iterable_extensions.dart';
import '../models/dish.dart';

mixin OrderRepository {
  static Future<void> save(
    String apiUrl,
    int userId,
    DateTime date,
    Iterable<Dish> dishes,
  ) async {
    await http.post(
      '$apiUrl/order/save-order',
      headers: <String, String>{'Content-type': 'application/json'},
      body: json.encode(
        <String, dynamic>{
          'userId': userId,
          'date': DateFormat('yyyy-MM-dd').format(date),
          'dishIds': dishes.expand(_expandDish).ids.toList(),
        },
      ),
    );
  }

  static Iterable<Dish> _expandDish(Dish dish) =>
      List<Dish>.filled(dish.count, dish);
}
