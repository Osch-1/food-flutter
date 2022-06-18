import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'app_config.dart';
import 'core/locale_helper.dart';
import 'l10n/app_localizations.dart';
import 'l10n/app_localizations_delegate.dart';
import 'models/user.dart';
import 'pages/home_page.dart';
import 'providers/menu_provider.dart';
import 'providers/users_provider.dart';
import 'widgets/snack_bar_message.dart';
import 'widgets/top_bar.dart';

class FoodOrderingApp extends StatefulWidget {
  @override
  _FoodOrderingAppState createState() => _FoodOrderingAppState();
}

class _FoodOrderingAppState extends State<FoodOrderingApp> {
  static const List<LocalizationsDelegate<dynamic>> _localizationDelegates =
      <LocalizationsDelegate<dynamic>>[
    AppLocalizationsDelegate(),
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  static const List<Locale> _locales = <Locale>[
    LocaleHelper.enUs,
    LocaleHelper.ruRu
  ];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  AppLocalizations _localizations;
  Future<Iterable<User>> _users =
      Future<Iterable<User>>.value(const Iterable<User>.empty());
  User _user;
  Future<Iterable<DateTime>> _availableDates =
      Future<Iterable<DateTime>>.value(const Iterable<DateTime>.empty());
  Widget Function(
    AppLocalizations,
    User,
    Future<Iterable<DateTime>>,
  ) _bodyGetter;

  @override
  void initState() {
    super.initState();

    Timer.run(
      () => setState(
        () {
          _users = UsersProvider.getUsers();
          _availableDates =
              MenuProvider.getAvailableDates(AppConfig.of(context).apiBaseUrl)
                ..then(
                  (Iterable<DateTime> availableDates) {
                    if ((availableDates.isNotEmpty) &&
                        _scaffoldKey.currentState != null) {
                      _scaffoldKey.currentState.showSnackBar(
                        SnackBar(
                          content: SnackBarMessage(
                            localizations: _localizations,
                            availableDates: availableDates,
                          ),
                        ),
                      );
                    }
                  },
                );
        },
      ),
    );

    _updateLocale(LocaleHelper.ruRu);
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        onGenerateTitle: (BuildContext context) =>
            _localizations?.appTitle ?? AppLocalizations.of(context).appTitle,
        localizationsDelegates: _localizationDelegates,
        supportedLocales: _locales,
        theme: ThemeData(primaryColor: const Color(0xFF0047a8)),
        home: Scaffold(
          key: _scaffoldKey,
          appBar: TopBar(
            localizations: _localizations,
            users: _users,
            user: _user,
            onBodyGetterChange: _setBodyGetter,
            onUserChanged: _setUser,
            locales: _locales,
            onLocaleChanged: _updateLocale,
          ),
          body: _bodyGetter == null
              ? HomePage(
                  localizations: _localizations,
                  user: _user,
                  availableDates: _availableDates,
                )
              : _bodyGetter(
                  _localizations,
                  _user,
                  _availableDates,
                ),
        ),
      );

  void _setBodyGetter(
    Widget Function(
      AppLocalizations,
      User,
      Future<Iterable<DateTime>>,
    )
        bodyGetter,
  ) =>
      setState(() => _bodyGetter = bodyGetter);

  void _setUser(User user) => setState(() => _user = user);

  void _updateLocale(Locale locale) => AppLocalizations.load(locale).then(
        (AppLocalizations localizations) async {
          await initializeDateFormatting(locale.toString());
          setState(() => _localizations = localizations);
        },
      );
}
