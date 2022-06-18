import 'package:flutter/material.dart';

import '../core/iterable_extensions.dart';
import '../l10n/app_localizations.dart';
import '../models/dish.dart';
import 'dishes_category.dart';

class DayMenu extends StatelessWidget {
  const DayMenu({
    this.localizations,
    this.availableDishes,
    this.parentSize,
    this.textStyle,
    this.readOnly,
    this.onDishIncrement,
    this.onDishDecrement,
  });

  static const double _denseWidth = 8.0 * 100;

  final AppLocalizations localizations;
  final Iterable<Dish> availableDishes;
  final Size parentSize;
  final TextStyle textStyle;
  final bool readOnly;
  final void Function(Dish dish) onDishIncrement;
  final void Function(Dish dish) onDishDecrement;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 8.0 * 2),
        child: Row(
          children: <Widget>[
            Expanded(
              child: DishesCategory(
                localizations: localizations,
                name: localizations?.salad ?? '',
                iconName: 'salad.png',
                parentSize: parentSize,
                textStyle: textStyle,
                dishes: availableDishes?.salads,
                readOnly: readOnly,
                onDishIncrement: onDishIncrement,
                onDishDecrement: onDishDecrement,
              ),
            ),
            Expanded(
              child: DishesCategory(
                localizations: localizations,
                name: localizations?.soup ?? '',
                iconName: 'soup.png',
                parentSize: parentSize,
                textStyle: textStyle,
                dishes: availableDishes?.soups,
                readOnly: readOnly,
                onDishIncrement: onDishIncrement,
                onDishDecrement: onDishDecrement,
              ),
            ),
            Expanded(
              child: DishesCategory(
                localizations: localizations,
                name: (parentSize.width < _denseWidth
                        ? localizations?.shortRoast
                        : localizations?.roast) ??
                    '',
                iconName: 'roast.png',
                parentSize: parentSize,
                textStyle: textStyle,
                dishes: availableDishes?.roasts,
                readOnly: readOnly,
                onDishIncrement: onDishIncrement,
                onDishDecrement: onDishDecrement,
              ),
            ),
            Expanded(
              child: DishesCategory(
                localizations: localizations,
                name: localizations?.garnish ?? '',
                iconName: 'garnish.png',
                parentSize: parentSize,
                textStyle: textStyle,
                dishes: availableDishes?.garnishes,
                readOnly: readOnly,
                onDishIncrement: onDishIncrement,
                onDishDecrement: onDishDecrement,
              ),
            ),
          ],
        ),
      );
}
