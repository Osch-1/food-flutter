extension DateTimeExtensions on DateTime {
  DateTime get firstDayOfWeek => DateTime(year, month, day - weekday + 1);
  DateTime addDays(int days) => add(Duration(days: days));
}
