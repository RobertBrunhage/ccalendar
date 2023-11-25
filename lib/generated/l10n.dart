// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `ops, something went wrong, try again.`
  String get failedToLoad {
    return Intl.message(
      'ops, something went wrong, try again.',
      name: 'failedToLoad',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get close {
    return Intl.message(
      'Close',
      name: 'close',
      desc: '',
      args: [],
    );
  }

  /// `Nessa's Christmas Calendar`
  String get title {
    return Intl.message(
      'Nessa\'s Christmas Calendar',
      name: 'title',
      desc: '',
      args: [],
    );
  }

  /// `{days} {days,plural, =1{day} other{days}} {hours} {hours,plural, =1{hour} other{hours}} {minutes} {minutes,plural, =1{minute} other{minutes}} {seconds} {seconds,plural, =1{second} other{seconds}}`
  String allTimeRemaining(num days, num hours, num minutes, num seconds) {
    return Intl.message(
      '$days ${Intl.plural(days, one: 'day', other: 'days')} $hours ${Intl.plural(hours, one: 'hour', other: 'hours')} $minutes ${Intl.plural(minutes, one: 'minute', other: 'minutes')} $seconds ${Intl.plural(seconds, one: 'second', other: 'seconds')}',
      name: 'allTimeRemaining',
      desc: '',
      args: [days, hours, minutes, seconds],
    );
  }

  /// `{hours} {hours,plural, =1{hour} other{hours}} {minutes} {minutes,plural, =1{minute} other{minutes}} {seconds} {seconds,plural, =1{second} other{seconds}}`
  String hoursRemaining(num hours, num minutes, num seconds) {
    return Intl.message(
      '$hours ${Intl.plural(hours, one: 'hour', other: 'hours')} $minutes ${Intl.plural(minutes, one: 'minute', other: 'minutes')} $seconds ${Intl.plural(seconds, one: 'second', other: 'seconds')}',
      name: 'hoursRemaining',
      desc: '',
      args: [hours, minutes, seconds],
    );
  }

  /// `{minutes} {minutes,plural, =1{minute} other{minutes}} {seconds} {seconds,plural, =1{second} other{seconds}}`
  String minutesRemaining(num minutes, num seconds) {
    return Intl.message(
      '$minutes ${Intl.plural(minutes, one: 'minute', other: 'minutes')} $seconds ${Intl.plural(seconds, one: 'second', other: 'seconds')}',
      name: 'minutesRemaining',
      desc: '',
      args: [minutes, seconds],
    );
  }

  /// `{seconds} {seconds,plural, =1{second} other{seconds}}`
  String secondsRemaining(num seconds) {
    return Intl.message(
      '$seconds ${Intl.plural(seconds, one: 'second', other: 'seconds')}',
      name: 'secondsRemaining',
      desc: '',
      args: [seconds],
    );
  }

  /// `First box can be opened in`
  String get opensIn {
    return Intl.message(
      'First box can be opened in',
      name: 'opensIn',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
