import 'package:flutter/material.dart';
import 'select.dart';

class LocaleSelect extends Select<Locale> {
  const LocaleSelect({
    Map<String, Locale> locales,
    Locale defaultLanguage,
    String defaultLanguageDescription,
    void Function(Locale) onChanged,
    String dialogTitle,
    TextStyle textStyle,
  }) : super(
          options: locales,
          value: defaultLanguage,
          valueDescription: defaultLanguageDescription,
          onChanged: onChanged,
          dialogTitle: dialogTitle,
          textStyle: textStyle,
        );
}
