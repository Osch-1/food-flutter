// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function>{
        "account": MessageLookupByLibrary.simpleMessage("Account"),
        "app_title": MessageLookupByLibrary.simpleMessage("Food ordering"),
        "call_to_order": MessageLookupByLibrary.simpleMessage("Order food for"),
        "camera": MessageLookupByLibrary.simpleMessage("Kitchen camera"),
        "garnish": MessageLookupByLibrary.simpleMessage("Garnish"),
        "monthly_report":
            MessageLookupByLibrary.simpleMessage("Monthly report"),
        "order_for_today":
            MessageLookupByLibrary.simpleMessage("Order for today"),
        "price": MessageLookupByLibrary.simpleMessage("Price"),
        "roast": MessageLookupByLibrary.simpleMessage("Roast"),
        "salad": MessageLookupByLibrary.simpleMessage("Salad"),
        "select_locale":
            MessageLookupByLibrary.simpleMessage("Select language"),
        "select_user": MessageLookupByLibrary.simpleMessage("Select user"),
        "short_roast": MessageLookupByLibrary.simpleMessage("Roast"),
        "short_select_user":
            MessageLookupByLibrary.simpleMessage("Select\nuser"),
        "soup": MessageLookupByLibrary.simpleMessage("Soup"),
        "weight": MessageLookupByLibrary.simpleMessage("Weight"),
        "weight_unit_symbol": MessageLookupByLibrary.simpleMessage("g")
      };
}
