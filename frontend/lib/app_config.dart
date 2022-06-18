import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class AppConfig extends InheritedWidget {
  const AppConfig({@required this.apiBaseUrl, @required Widget child})
      : super(child: child);

  final String apiBaseUrl;

  static AppConfig of(BuildContext context) =>
      // ignore:avoid_as
      context.dependOnInheritedWidgetOfExactType(aspect: AppConfig);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}
