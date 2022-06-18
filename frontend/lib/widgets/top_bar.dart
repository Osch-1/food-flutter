import 'package:flutter/material.dart';

import '../core/iterable_extensions.dart';
import '../core/locale_extensions.dart';
import '../core/locale_helper.dart';
import '../l10n/app_localizations.dart';
import '../models/user.dart';
import '../pages/account_page.dart';
import '../pages/camera_page.dart';
import '../pages/home_page.dart';

import 'locale_select.dart';
import 'select.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  const TopBar({
    this.localizations,
    this.users,
    this.user,
    this.onBodyGetterChange,
    this.onUserChanged,
    this.locales,
    this.onLocaleChanged,
  });

  static const double _denseWidth = 8.0 * 100;

  final AppLocalizations localizations;
  final Future<Iterable<User>> users;
  final User user;
  final void Function(
    Widget Function(
      AppLocalizations,
      User,
      Future<Iterable<DateTime>>,
    ),
  ) onBodyGetterChange;
  final void Function(User) onUserChanged;
  final List<Locale> locales;
  final void Function(Locale) onLocaleChanged;

  @override
  Widget build(BuildContext context) => AppBar(
        leading: _buildLogo(context),
        title: _buildAppTitle(context),
        actions: _buildActions(context),
      );

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  Widget _buildLogo(BuildContext context) => IconButton(
        onPressed: () => _navigateToOrder(context),
        icon: const Image(
          image: AssetImage('assets/images/app_bar_logo.png'),
        ),
      );

  Widget _buildAppTitle(BuildContext context) => GestureDetector(
        onTap: () => _navigateToOrder(context),
        child: Text(localizations?.appTitle ?? ''),
      );

  void _navigateToOrder(BuildContext context) => onBodyGetterChange(
        (
          AppLocalizations localizations,
          User user,
          Future<Iterable<DateTime>> availableDates,
        ) =>
            HomePage(
          localizations: localizations,
          user: user,
          availableDates: availableDates,
        ),
      );

  List<Widget> _buildActions(BuildContext context) {
    final TextTheme primaryTextTheme = Theme.of(context).primaryTextTheme;
    final Size parentSize = MediaQuery.of(context).size;
    final TextStyle textStyle = TextStyle(
      color: primaryTextTheme.headline6.color,
      fontSize: primaryTextTheme.subtitle1.fontSize,
    );

    return <Widget>[
      Center(
        child: IconButton(
          onPressed: () => _navigateToCamera(context),
          icon: const Icon(Icons.linked_camera),
          tooltip: localizations?.camera,
        ),
      ),
      Center(
        child: IconButton(
          onPressed: user == null
              ? null
              : () => _navigateToAccount(context, parentSize),
          icon: const Icon(Icons.account_circle),
          tooltip: localizations?.account,
        ),
      ),
      const SizedBox(width: 8),
      Center(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints boxConstraints) =>
              _buildUserSelect(context, parentSize, textStyle),
        ),
      ),
      const SizedBox(width: 8),
      Center(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints boxConstraints) =>
              _buildLanguageSelect(context, textStyle),
        ),
      ),
    ];
  }

  void _navigateToCamera(BuildContext context) =>
      onBodyGetterChange((_, __, ___) => const CameraPage());

  void _navigateToAccount(
    BuildContext context,
    Size parentSize,
  ) =>
      onBodyGetterChange(
        (AppLocalizations localizations, User user, _) => AccountPage(
          localizations: localizations,
          user: user,
          parentSize: parentSize,
        ),
      );

  Widget _buildUserSelect(
      BuildContext context, Size parentSize, TextStyle textStyle) {
    final String activeUserName = parentSize.width < _denseWidth
        ? user?.shortName ?? localizations?.shortSelectUser
        : user?.name ?? localizations?.selectUser;

    return FutureBuilder<Iterable<User>>(
      future: users,
      builder: (_, AsyncSnapshot<Iterable<User>> snapshot) => Select<User>(
        options: (snapshot.hasData ? snapshot.data : <User>[])?.toMap(),
        value: user,
        valueDescription: activeUserName,
        onChanged: onUserChanged,
        dialogTitle: localizations?.selectUser ?? '',
        textStyle: textStyle,
      ),
    );
  }

  Widget _buildLanguageSelect(BuildContext context, TextStyle textStyle) {
    final Size parentSize = MediaQuery.of(context).size;
    final Locale activeLocale = localizations?.locale ?? LocaleHelper.enUs;
    final String activeLocaleDescription = parentSize.width < _denseWidth
        ? activeLocale.shortDescription
        : activeLocale.description;
    return LocaleSelect(
      locales: locales?.toMap(),
      defaultLanguage: activeLocale,
      defaultLanguageDescription: activeLocaleDescription,
      onChanged: onLocaleChanged,
      dialogTitle: localizations?.selectLocale ?? '',
      textStyle: textStyle,
    );
  }
}
