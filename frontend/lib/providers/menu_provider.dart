import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../models/dish.dart';

mixin MenuProvider {
  static Future<Iterable<DateTime>> getAvailableDates(String apiUrl) async {
    final http.Response response =
        await http.get('$apiUrl/menu/available-dates');

    return response.statusCode == 200
        ? _deserializeDates(response.body)
        : <DateTime>[];
  }

  static Future<Iterable<Dish>> getAvailableDishes(
      String apiUrl, DateTime date) async {
    final String dateString = DateFormat('yyyy-MM-dd').format(date);
    final http.Response response =
        await http.get('$apiUrl/menu/available-dishes?date=$dateString');

    return response.statusCode == 200
        ? _deserializeDishes(response.body)
        : <Dish>[];
  }

  static Iterable<DateTime> _deserializeDates(String data) {
    final Iterable<int> datesMillisecondsSinceEpoch =
        _asIterable(jsonDecode(data));

    return datesMillisecondsSinceEpoch
        .map(_createDateTimeFromMillisecondsSinceEpoch);
  }

  static Iterable<Dish> _deserializeDishes(String data) {
    final Iterable<Map<String, dynamic>> dishesJson =
        _asIterable(jsonDecode(data));

    return dishesJson.map(_createDishFromJson);
  }

  static Iterable<T> _asIterable<T>(dynamic data) =>
      // ignore:avoid_as
      data.cast<T>() as Iterable<T>;

  static DateTime _createDateTimeFromMillisecondsSinceEpoch(
          int millisecondsSinceEpoch) =>
      DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);

  static Dish _createDishFromJson(Map<String, dynamic> json) =>
      Dish.fromJson(json);
}
