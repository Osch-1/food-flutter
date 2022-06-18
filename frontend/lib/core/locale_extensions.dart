import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'locale_helper.dart';

extension LocaleExtensions on Locale {
  String get name =>
      Intl.canonicalizedLocale(countryCode.isEmpty ? languageCode : toString());

  String get description {
    if (this == LocaleHelper.enUs) {
      return 'English (United States)';
    } else if (this == LocaleHelper.ruRu) {
      return 'Русский (Россия)';
    }
    return toString();
  }

  String get shortDescription {
    if (this == LocaleHelper.enUs) {
      return 'En';
    } else if (this == LocaleHelper.ruRu) {
      return 'Ru';
    }
    return description;
  }
}
