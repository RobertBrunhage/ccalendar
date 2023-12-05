import 'dart:async';

import 'package:ccalender/calendar/calender_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:logging/logging.dart';
import 'package:ccalender/generated/l10n.dart';
import 'package:ccalender/ui_library/styles.dart';
import 'package:posthog_flutter/posthog_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main(){
  runApp(const AppInitializer());
}

sealed class AppLoadingState {}

class AppLoading extends AppLoadingState {}

class AppSuccessfulLoading extends AppLoadingState {}

class AppFailedLoading extends AppLoadingState {}

class AppInitializer extends StatefulWidget {
  const AppInitializer({super.key});

  @override
  State<AppInitializer> createState() => _AppInitializerState();
}

class _AppInitializerState extends State<AppInitializer> {
  ValueNotifier<AppLoadingState> loadingState = ValueNotifier(AppLoading());
  SharedPreferences? prefs;

  @override
  void initState() {
    super.initState();
    unawaited(bootstrap());
  }

  Future<void> bootstrap() async {
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((record) {
      if (!kReleaseMode) {
        debugPrint(
          '${record.level.name} : ${record.loggerName} : ${record.message}',
        );
      }
    });

    try {
      prefs = await SharedPreferences.getInstance();
      loadingState.value = AppSuccessfulLoading();
    } catch (e) {
      loadingState.value = AppFailedLoading();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: loadingState,
      builder: (context, state, child) {
        return switch (state) {
          AppLoading() => const ThemedApp(
              home: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          AppFailedLoading() => ThemedApp(
              home: Center(
                child: Text(S.of(context).failedToLoad),
              ),
            ),
          AppSuccessfulLoading() => MultiProvider(
              providers: [
                Provider<SharedPreferences>(
                  create: (BuildContext context) => prefs!,
                ),
                Provider<PosthogAnalyticsIntegration>(
                  create: (context) {
                    final analytics = Posthog();
                    return PosthogAnalyticsIntegration(analytics);
                  },
                ),
              ],
              child: const ThemedApp(
                home: CalendarView(),
              ),
            ),
        };
      },
    );
  }
}

class ThemedApp extends StatelessWidget {
  const ThemedApp({
    super.key,
    required this.home,
  });

  final Widget home;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      theme: ThemeData(
        fontFamily: 'MountainsOfChristmas',
        colorScheme: ColorScheme.fromSeed(
          seedColor: Styles$Colors.white100,
          surface: Colors.black,
        ),
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: Styles$Colors.black100,
        ),
        iconButtonTheme: IconButtonThemeData(
          style: ButtonStyle(
            splashFactory: NoSplash.splashFactory,
            enableFeedback: false,
            iconColor: MaterialStateProperty.all(Styles$Colors.grey600),
          ),
        ),
        useMaterial3: true,
      ),
      home: home,
    );
  }
}

class PosthogAnalyticsIntegration {
  PosthogAnalyticsIntegration(this.analytics) {
    // if(!kReleaseMode) {
    //   analytics.disable();
    // }
  }

  final Posthog analytics;

  Future<void> logEvent(String name, Map<String, dynamic> parameters) async {
    await analytics.capture(eventName: name, properties: parameters);
  }

  Future<void> logScreen(String name) async {
    await analytics.screen(screenName: name);
  }
}
