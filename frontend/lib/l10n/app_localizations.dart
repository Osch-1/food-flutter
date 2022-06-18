import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../core/locale_extensions.dart';
import 'messages_all.dart';

class AppLocalizations {
  AppLocalizations(this.locale) : localeName = locale.name;

  static Future<AppLocalizations> load(Locale locale) {
    final String localeName = locale.name;

    return initializeMessages(localeName).then((_) => AppLocalizations(locale));
  }

  static AppLocalizations of(BuildContext context) =>
      Localizations.of<AppLocalizations>(context, AppLocalizations);

  final Locale locale;
  final String localeName;

  String get appTitle => Intl.message(
        'app_title',
        desc: 'Application title',
        locale: localeName,
      );

  String get selectUser => Intl.message(
        'select_user',
        locale: localeName,
      );

  String get shortSelectUser => Intl.message(
        'short_select_user',
        locale: localeName,
      );

  String get selectLocale => Intl.message(
        'select_locale',
        locale: localeName,
      );

  String get account => Intl.message(
        'account',
        locale: localeName,
      );

  String get camera => Intl.message(
        'camera',
        locale: localeName,
      );

  String get callToOrder => Intl.message(
        'call_to_order',
        locale: localeName,
      );

  String get salad => Intl.message(
        'salad',
        locale: localeName,
      );

  String get soup => Intl.message(
        'soup',
        locale: localeName,
      );

  String get roast => Intl.message(
        'roast',
        locale: localeName,
      );

  String get shortRoast => Intl.message(
        'short_roast',
        locale: localeName,
      );

  String get garnish => Intl.message(
        'garnish',
        locale: localeName,
      );

  String get price => Intl.message(
        'price',
        locale: localeName,
      );

  String get weight => Intl.message(
        'weight',
        locale: localeName,
      );

  String get weightUnitSymbol => Intl.message(
        'weight_unit_symbol',
        locale: localeName,
      );

  String get orderForToday => Intl.message(
        'order_for_today',
        locale: localeName,
      );

  String get monthlyReport => Intl.message(
        'monthly_report',
        locale: localeName,
      );
}
