// ignore_for_file:avoid_as
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:food_ordering/core/locale_helper.dart';
import 'package:food_ordering/core/locale_extensions.dart';
import 'package:food_ordering/food_ordering_app.dart';
import 'package:food_ordering/widgets/locale_select.dart';

void main() {
  testWidgets('Change language test', (WidgetTester tester) async {
    Future<void> selectLanguage(String language) async {
      final Finder localeSelectorFinder = find.byType(LocaleSelect);
      expect(localeSelectorFinder, findsOneWidget);

      await tester.tap(localeSelectorFinder.last);
      await tester.pump();

      final Finder localeOptionFinder = find.text(language);
      expect(localeOptionFinder, findsWidgets);

      await tester.tap(localeOptionFinder.last);
      await tester.pump();
    }

    String getAppBarTitleText() {
      final Finder appBarFinder = find.byType(AppBar);
      expect(appBarFinder, findsOneWidget);

      final AppBar appBarWidget =
          appBarFinder.evaluate().single.widget as AppBar;
      final GestureDetector appBarWidgetTitle =
          appBarWidget.title as GestureDetector;
      return (appBarWidgetTitle.child as Text).data;
    }

    await tester.pumpWidget(FoodOrderingApp());
    await tester.pumpAndSettle();

    await selectLanguage(LocaleHelper.enUs.description);
    final String englishAppBarTitleText = getAppBarTitleText();

    await selectLanguage(LocaleHelper.ruRu.description);
    final String russianAppBarTitleText = getAppBarTitleText();

    expect(englishAppBarTitleText, isNot(russianAppBarTitleText));
  });
}
