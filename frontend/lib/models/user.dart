import 'package:flutter/material.dart';

@immutable
class User {
  User(this.id, this.name, [String shortName])
      : shortName = shortName ?? _getShortName(name);

  final int id;
  final String name;
  final String shortName;

  @override
  bool operator ==(dynamic other) => other is User && other.id == id;

  @override
  int get hashCode => id;

  static String _getShortName(String name) {
    final RegExp regExp = RegExp('^([А-Яа-яё]+?)\\s([А-Я]).*?\\s([А-Я]).*\$');
    final Iterable<RegExpMatch> matches = regExp.allMatches(name);
    if (matches.isEmpty) {
      return name;
    }
    final RegExpMatch match = matches.first;
    return '${match.group(1)} ${match.group(2)}. ${match.group(3)}.';
  }
}
