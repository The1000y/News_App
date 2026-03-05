import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:news_app/core/config/app_routes.dart';
import 'package:news_app/core/provider/app_provider.dart';
import 'package:news_app/core/themes/theme_manager.dart';
import 'package:news_app/l10n/app_localizations.dart';
import 'package:news_app/modules/view/sceens/widgets/custom_drawer_widget.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, provider, child) {
        return MaterialApp(
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            Locale('en'), // English
            Locale('ar'), //
          ],
          locale: Locale(
            provider.selectedLanguage == SelectedLanguage.en ? 'en' : 'ar',
          ),
          debugShowCheckedModeBanner: false,

          title: 'Flutter Demo',
          theme: ThemeManager.getLight(
            provider.selectedLanguage == SelectedLanguage.en ? 'en' : 'ar',
          ),
          darkTheme: ThemeManager.getDark(
            provider.selectedLanguage == SelectedLanguage.en ? 'en' : 'ar',
          ),
          themeMode: provider.selectedTheme == SelectedTheme.dark
              ? ThemeMode.dark
              : ThemeMode.light,

          onGenerateRoute: AppRoute.onGenerateRoute,
        );
      },
    );
  }
}
