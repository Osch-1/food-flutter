import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../l10n/app_localizations.dart';

class SnackBarMessage extends StatelessWidget {
  const SnackBarMessage({this.localizations, this.availableDates});

  final AppLocalizations localizations;
  final Iterable<DateTime> availableDates;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations =
        localizations ?? AppLocalizations.of(context);

    final String availableDatesString = availableDates
            ?.map((DateTime availableDate) => _formatDate(
                availableDate, appLocalizations?.locale?.toString()))
            ?.join(', ') ??
        '';
    final String callToOrder = availableDatesString.isEmpty
        ? ''
        : '${appLocalizations?.callToOrder ?? ''} $availableDatesString!';

    return callToOrder.isEmpty
        ? const SizedBox.shrink()
        : Text(callToOrder,
            style: Theme.of(context).primaryTextTheme.headline6);
  }

  String _formatDate(DateTime date, String localeString) => DateFormat(
        DateFormat.MONTH_DAY,
        localeString,
      ).format(date);
}
