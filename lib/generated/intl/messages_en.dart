// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(days, hours, minutes, seconds) =>
      "${days} ${Intl.plural(days, one: 'day', other: 'days')} ${hours} ${Intl.plural(hours, one: 'hour', other: 'hours')} ${minutes} ${Intl.plural(minutes, one: 'minute', other: 'minutes')} ${seconds} ${Intl.plural(seconds, one: 'second', other: 'seconds')}";

  static String m1(hours, minutes, seconds) =>
      "${hours} ${Intl.plural(hours, one: 'hour', other: 'hours')} ${minutes} ${Intl.plural(minutes, one: 'minute', other: 'minutes')} ${seconds} ${Intl.plural(seconds, one: 'second', other: 'seconds')}";

  static String m2(minutes, seconds) =>
      "${minutes} ${Intl.plural(minutes, one: 'minute', other: 'minutes')} ${seconds} ${Intl.plural(seconds, one: 'second', other: 'seconds')}";

  static String m3(seconds) =>
      "${seconds} ${Intl.plural(seconds, one: 'second', other: 'seconds')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "allTimeRemaining": m0,
        "close": MessageLookupByLibrary.simpleMessage("Close"),
        "failedToLoad": MessageLookupByLibrary.simpleMessage(
            "ops, something went wrong, try again."),
        "hoursRemaining": m1,
        "minutesRemaining": m2,
        "opensIn":
            MessageLookupByLibrary.simpleMessage("First box can be opened in"),
        "secondsRemaining": m3,
        "title":
            MessageLookupByLibrary.simpleMessage("Nessa\'s Christmas Calendar")
      };
}
