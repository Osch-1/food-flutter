import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../models/dish.dart';
import 'dish_card.dart';

class DishesCategory extends StatelessWidget {
  const DishesCategory({
    this.localizations,
    this.name,
    this.iconName,
    this.parentSize,
    this.textStyle,
    this.dishes,
    this.readOnly,
    this.onDishIncrement,
    this.onDishDecrement,
  });

  static const double _denseWidth = 8.0 * 100;

  final AppLocalizations localizations;
  final String name;
  final String iconName;
  final Size parentSize;
  final TextStyle textStyle;
  final Iterable<Dish> dishes;
  final bool readOnly;
  final void Function(Dish dish) onDishIncrement;
  final void Function(Dish dish) onDishDecrement;

  @override
  Widget build(BuildContext context) => Column(
        children: <Widget>[
          _buildCategory(
            name: name,
            iconName: iconName,
            parentSize: parentSize,
            textStyle: textStyle,
          ),
          if (dishes != null)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: ListView(
                  children: dishes
                      .map(
                        (Dish dish) => DishCard(
                          localizations: localizations,
                          dish: dish,
                          parentSize: parentSize,
                          readOnly: readOnly,
                          onDishIncrement: onDishIncrement,
                          onDishDecrement: onDishDecrement,
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
        ],
      );

  Widget _buildCategory({
    String name,
    String iconName,
    Size parentSize,
    TextStyle textStyle,
  }) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _buildCategoryIcon(iconName, parentSize),
          const SizedBox(width: 8),
          Flexible(child: Text(name, style: textStyle)),
        ],
      );

  Widget _buildCategoryIcon(String iconName, Size parentSize) {
    final double size = parentSize.width < _denseWidth ? 24 : 36;
    final EdgeInsets padding = parentSize.width < _denseWidth
        ? const EdgeInsets.all(8)
        : const EdgeInsets.all(8.0 * 2);

    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.blue.shade700,
        borderRadius: BorderRadius.circular(8.0 * 5),
      ),
      child: Image(
        width: size,
        height: size,
        image: AssetImage('assets/images/$iconName'),
      ),
    );
  }
}
