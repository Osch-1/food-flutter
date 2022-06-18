import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../models/dish_set.dart';

mixin OrderProvider {
  static Future<Iterable<DishSet>> getOrderDishes(
    String apiUrl,
    int userId,
    DateTime date,
  ) async {
    final String dateString = DateFormat('yyyy-MM-dd').format(date);
    final http.Response response = await http
        .get('$apiUrl/order/get-order-dishes?userId=$userId&date=$dateString');

    return response.statusCode == 200
        ? _deserializeDishSets(response.body)
        : <DishSet>[];
  }

  static Future<Iterable<int>> getOrderIds(
    String apiUrl,
    int userId,
    DateTime date,
  ) async {
    final String dateString = DateFormat('yyyy-MM-dd').format(date);
    final http.Response response = await http
        .get('$apiUrl/order/get-order?userId=$userId&date=$dateString');

    return response.statusCode == 200
        ? _deserializeIntegers(response.body)
        : <int>[];
  }

  static Iterable<DishSet> _deserializeDishSets(String data) {
    final Iterable<Map<String, dynamic>> dishSetsJson =
        _asIterable(jsonDecode(data));

    return dishSetsJson.map(_createDishSetFromJson);
  }

  static DishSet _createDishSetFromJson(Map<String, dynamic> json) =>
      DishSet.fromJson(json);

  static Iterable<int> _deserializeIntegers(String data) =>
      _asIterable(jsonDecode(data));

  static Iterable<T> _asIterable<T>(dynamic data) =>
      // ignore:avoid_as
      data.cast<T>() as Iterable<T>;
}
