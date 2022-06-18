import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../core/locale_helper.dart';
import '../l10n/app_localizations.dart';
import '../models/dish.dart';
import '../models/user.dart';
import 'day_menu.dart';

class OrderingMenu extends StatefulWidget {
  const OrderingMenu({
    this.localizations,
    this.dates,
    this.availableDates,
    this.availableDishes,
    this.user,
    this.onDateChange,
    this.onDishIncrement,
    this.onDishDecrement,
  });

  final AppLocalizations localizations;
  final List<DateTime> dates;
  final Future<Iterable<DateTime>> availableDates;
  final Iterable<Dish> availableDishes;
  final User user;
  final void Function(DateTime) onDateChange;
  final void Function(Dish dish) onDishIncrement;
  final void Function(Dish dish) onDishDecrement;

  @override
  _OrderingMenuState createState() => _OrderingMenuState();
}

class _OrderingMenuState extends State<OrderingMenu>
    with SingleTickerProviderStateMixin {
  static const double _denseWidth = 8.0 * 100;

  TabController _tabController;
  int _previousUserId;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(vsync: this, length: widget.dates.length)
      ..addListener(_validateTabIndex);
    _validateTabIndex();
  }

  @override
  void didUpdateWidget(OrderingMenu oldWidget) {
    super.didUpdateWidget(oldWidget);

    widget.availableDates.then(
      (Iterable<DateTime> availableDates) {
        final DateTime selectedDate = widget.dates[_tabController.index];
        if (!(availableDates?.contains(selectedDate) ?? false)) {
          _getFirstAvailableTabIndex().then(
            (int firstAvailableTabIndex) {
              if (firstAvailableTabIndex != -1) {
                final DateTime previousSelectedDate =
                    widget.dates[_tabController.previousIndex];
                final bool isPreviousDateAvailable =
                    availableDates?.contains(previousSelectedDate) ?? false;
                _tabController.index = isPreviousDateAvailable
                    ? _tabController.previousIndex
                    : firstAvailableTabIndex;
              }
            },
          );
        }
      },
    );

    if (widget.user?.id != _previousUserId) {
      widget.onDateChange(widget.dates[_tabController.index]);
      _previousUserId = widget.user?.id;
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String localeString = widget.localizations?.locale?.toString() ??
        LocaleHelper.enUs.toString();
    final TextStyle textStyle = Theme.of(context).textTheme.subtitle1;
    final Size parentSize = MediaQuery.of(context).size;

    return Column(
      children: <Widget>[
        TabBar(
          controller: _tabController,
          labelColor: const Color(0xFF254666),
          labelPadding: const EdgeInsets.all(8),
          tabs: _buildTabs(parentSize, localeString),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            physics: const NeverScrollableScrollPhysics(),
            children: _buildTabViews(parentSize, textStyle),
          ),
        ),
      ],
    );
  }

  void _validateTabIndex() {
    final DateTime selectedDate = widget.dates[_tabController.index];
    widget.availableDates.then(
      (Iterable<DateTime> availableDates) {
        if (availableDates?.contains(selectedDate) ?? false) {
          widget.onDateChange(widget.dates[_tabController.index]);
        } else {
          final DateTime previousSelectedDate =
              widget.dates[_tabController.previousIndex];
          final bool isPreviousDateAvailable =
              availableDates?.contains(previousSelectedDate) ?? false;
          _getFirstAvailableTabIndex().then(
            (int firstAvailableTabIndex) {
              if (firstAvailableTabIndex != -1) {
                _tabController.index = isPreviousDateAvailable
                    ? _tabController.previousIndex
                    : firstAvailableTabIndex;
              }
            },
          );
        }
      },
    );
  }

  Future<int> _getFirstAvailableTabIndex() async {
    final Iterable<DateTime> availableDates = await widget.availableDates;
    return widget.dates.indexWhere(availableDates?.contains ?? (_) => true);
  }

  List<Widget> _buildTabs(Size parentSize, String localeString) => widget.dates
      .map((DateTime date) => _buildTab(parentSize, localeString, date))
      .toList();

  Widget _buildTab(
    Size parentSize,
    String localeString,
    DateTime weekdayDate,
  ) =>
      FutureBuilder<Iterable<DateTime>>(
        future: widget.availableDates,
        builder: (_, AsyncSnapshot<Iterable<DateTime>> snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox.shrink();
          }
          final Color textColor =
              snapshot.data.contains(weekdayDate) ? Colors.red : null;
          return Column(
            children: <Widget>[
              Text(
                _getWeekday(parentSize, localeString, weekdayDate),
                style: TextStyle(fontWeight: FontWeight.bold, color: textColor),
              ),
              Text(
                _getMonthDay(parentSize, localeString, weekdayDate),
                style: TextStyle(color: textColor),
              )
            ],
          );
        },
      );

  List<Widget> _buildTabViews(Size parentSize, TextStyle textStyle) =>
      widget.dates
          .map(
            (DateTime date) => DayMenu(
              localizations: widget.localizations,
              availableDishes: widget.availableDishes,
              parentSize: parentSize,
              textStyle: textStyle,
              readOnly: widget.user == null,
              onDishIncrement: widget.onDishIncrement,
              onDishDecrement: widget.onDishDecrement,
            ),
          )
          .toList();

  static String _getWeekday(
    Size parentSize,
    String localeString,
    DateTime weekdayDate,
  ) =>
      toBeginningOfSentenceCase(_getDateFormatted(
        parentSize.width,
        DateFormat.WEEKDAY,
        DateFormat.ABBR_WEEKDAY,
        localeString,
        weekdayDate,
      ));

  static String _getMonthDay(
    Size parentSize,
    String localeString,
    DateTime weekdayDate,
  ) =>
      _getDateFormatted(
        parentSize.width,
        DateFormat.MONTH_DAY,
        DateFormat.ABBR_MONTH_DAY,
        localeString,
        weekdayDate,
      );

  static String _getDateFormatted(
    double width,
    String pattern,
    String shortPattern,
    String localeString,
    DateTime date,
  ) =>
      DateFormat(width < _denseWidth ? shortPattern : pattern, localeString)
          .format(date);
}
