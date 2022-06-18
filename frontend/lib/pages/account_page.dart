import 'package:flutter/material.dart';

import '../app_config.dart';
import '../l10n/app_localizations.dart';
import '../models/dish.dart';
import '../models/dish_set.dart';
import '../models/user.dart';
import '../providers/order_provider.dart';
import '../widgets/day_menu.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({
    this.localizations,
    this.user,
    this.parentSize,
  });

  final AppLocalizations localizations;
  final User user;
  final Size parentSize;

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  Future<Iterable<DishSet>> _dishSets;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _dishSets ??= OrderProvider.getOrderDishes(
      AppConfig.of(context).apiBaseUrl,
      widget.user.id,
      DateTime.now(),
    );

    return Padding(
      padding: const EdgeInsets.only(
        left: 8.0 * 2,
        top: 8.0 * 2,
        right: 8.0 * 2,
      ),
      child: Column(
        children: <Widget>[
          TabBar(
            controller: _tabController,
            labelColor: const Color(0xFF254666),
            labelPadding: const EdgeInsets.all(8),
            tabs: _buildTabs(),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              physics: const NeverScrollableScrollPhysics(),
              children: _buildTabViews(widget.parentSize),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildTabs() => <Widget>[
        Text(widget.localizations?.orderForToday ?? ''),
        Text(widget.localizations?.monthlyReport ?? ''),
      ];

  List<Widget> _buildTabViews(Size parentSize) => <Widget>[
        FutureBuilder<Iterable<DishSet>>(
          future: _dishSets,
          builder: (_, AsyncSnapshot<Iterable<DishSet>> snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox.shrink();
            }
            final Iterable<DishSet> dishSets = snapshot.data;
            final TextStyle textStyle = Theme.of(context).textTheme.subtitle1;

            return DayMenu(
              localizations: widget.localizations,
              availableDishes: dishSets
                  .map(DishSet.getDishes)
                  .expand((Iterable<Dish> dishes) => dishes),
              parentSize: parentSize,
              textStyle: textStyle,
              readOnly: true,
            );
          },
        ),
        const SizedBox.shrink(),
      ];
}
