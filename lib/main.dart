import 'dart:async';

import 'package:ccalender/calendar/calender_view.dart';
import 'package:ccalender/firebase_options.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:logging/logging.dart';
import 'package:ccalender/generated/l10n.dart';
import 'package:ccalender/ui_library/styles.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.web,
  );

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
                Provider<FirebaseAnalyticsIntegration>(
                  create: (context) {
                    final analytics = FirebaseAnalytics.instance;
                    return FirebaseAnalyticsIntegration(analytics);
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

class FirebaseAnalyticsIntegration {
  FirebaseAnalyticsIntegration(this.analytics) {
    analytics.setAnalyticsCollectionEnabled(kReleaseMode);
  }

  final FirebaseAnalytics analytics;

  Future<void> logEvent(String name, Map<String, dynamic> parameters) async {
    await analytics.logEvent(name: name, parameters: parameters);
  }

  Future<void> logScreen(String name) async {
    await analytics.setCurrentScreen(screenName: name);
  }
}
