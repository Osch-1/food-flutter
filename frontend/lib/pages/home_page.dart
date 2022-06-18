import 'package:flutter/material.dart';

import '../app_config.dart';
import '../core/date_time_extensions.dart';
import '../core/iterable_extensions.dart';
import '../l10n/app_localizations.dart';
import '../models/dish.dart';
import '../models/user.dart';
import '../providers/menu_provider.dart';
import '../providers/order_provider.dart';
import '../repositories/order_repository.dart';
import '../widgets/ordering_menu.dart';
import '../widgets/total_price/total_price.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    this.localizations,
    this.user,
    this.availableDates,
  });

  final AppLocalizations localizations;
  final User user;
  final Future<Iterable<DateTime>> availableDates;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const int workingDaysPerWeek = DateTime.daysPerWeek - 2;

  DateTime today = DateTime.now();
  List<DateTime> _dates;
  DateTime _date;
  Iterable<Dish> _availableDishes;
  int _totalPrice = 0;

  @override
  void initState() {
    super.initState();
    _dates = <DateTime>[
      ...List<DateTime>.generate(workingDaysPerWeek, _getWeekday),
      _getWeekday(DateTime.daysPerWeek),
      _getWeekday(DateTime.daysPerWeek + 1),
    ];
  }

  @override
  Widget build(BuildContext context) => Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              left: 8.0 * 2,
              top: 8.0 * 2,
              right: 8.0 * 2,
            ),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: OrderingMenu(
                    localizations: widget.localizations,
                    dates: _dates,
                    availableDates: widget.availableDates,
                    availableDishes: _availableDishes,
                    user: widget.user,
                    onDateChange: _onDateChange,
                    onDishIncrement: _onDishIncrement,
                    onDishDecrement: _onDishDecrement,
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: TotalPrice(price: _totalPrice),
          ),
        ],
      );

  DateTime _getWeekday(int weekdayIndex) =>
      today.firstDayOfWeek.addDays(weekdayIndex);

  void _onDateChange(DateTime date) {
    _date = date;
    MenuProvider.getAvailableDishes(
      AppConfig.of(context).apiBaseUrl,
      date,
    ).then(
      (Iterable<Dish> availableDishes) async {
        final Iterable<int> selectedDishes = widget.user == null
            ? <int>[]
            : await OrderProvider.getOrderIds(
                AppConfig.of(context).apiBaseUrl,
                widget.user.id,
                date,
              );
        setState(() {
          _availableDishes = availableDishes.select(selectedDishes);
          _totalPrice = _availableDishes?.totalPrice ?? 0;
        });
      },
    );
  }

  void _onDishIncrement(Dish dish) {
    setState(() => _totalPrice += dish.price);
    _saveOrder();
  }

  void _onDishDecrement(Dish dish) {
    setState(() => _totalPrice -= dish.price);
    _saveOrder();
  }

  void _saveOrder() => OrderRepository.save(
        AppConfig.of(context).apiBaseUrl,
        widget.user.id,
        _date,
        _availableDishes.selected,
      );
}
