import 'package:flutter/material.dart';
import '../core/locale_extensions.dart';
import '../core/locale_helper.dart';

import 'app_localizations.dart';

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => <String>[
        LocaleHelper.enUs.name,
        LocaleHelper.ruRu.name
      ].contains(locale.name);

  @override
  Future<AppLocalizations> load(Locale locale) => AppLocalizations.load(locale);

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
