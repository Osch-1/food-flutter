import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../models/dish.dart';

class DishCard extends StatefulWidget {
  const DishCard({
    this.localizations,
    this.dish,
    this.parentSize,
    this.readOnly,
    this.onDishIncrement,
    this.onDishDecrement,
  });

  final AppLocalizations localizations;
  final Dish dish;
  final Size parentSize;
  final bool readOnly;
  final void Function(Dish dish) onDishIncrement;
  final void Function(Dish dish) onDishDecrement;

  @override
  _DishCardState createState() => _DishCardState();
}

class _DishCardState extends State<DishCard> {
  static const double _denseWidth = 8.0 * 100;

  @override
  Widget build(BuildContext context) => Tooltip(
        message:
            '${widget.dish.description}${widget.dish.description.isEmpty ? '' : '\n'}${widget.localizations?.weight ?? ''}: ${widget.dish.weight} ${widget.localizations?.weightUnitSymbol ?? ''}',
        padding: const EdgeInsets.all(8),
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8 * 0.5),
          color: widget.dish.isSelected ? Colors.green.shade50 : null,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: <Widget>[
                Expanded(child: _buildDishInfo(widget.dish)),
                if (!widget.readOnly)
                  Flex(
                    direction: widget.parentSize.width < _denseWidth
                        ? Axis.vertical
                        : Axis.horizontal,
                    verticalDirection: VerticalDirection.up,
                    children: _buildDishActions(widget.dish),
                  ),
              ],
            ),
          ),
        ),
      );

  Widget _buildDishInfo(Dish dish) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(dish.name),
          Text(
            '${widget.localizations?.price ?? ''}: ${dish.price} ₽',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      );

  List<Widget> _buildDishActions(Dish dish) => <Widget>[
        IconButton(
          onPressed: () => _incrementDish(dish),
          icon: Icon(Icons.remove),
        ),
        Text(dish.count.toString()),
        IconButton(
          onPressed: () => _decrementDish(dish),
          icon: Icon(Icons.add),
        ),
      ];

  void _incrementDish(Dish dish) {
    setState(() => dish.increment());
    widget.onDishIncrement?.call(dish);
  }

  void _decrementDish(Dish dish) {
    setState(() => dish.decrement());
    widget.onDishDecrement?.call(dish);
  }
}
