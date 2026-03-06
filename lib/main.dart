import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:news_app/core/config/app_routes.dart';
// import 'package:news_app/core/provider/app_provider.dart';
import 'package:news_app/core/themes/theme_manager.dart';
import 'package:news_app/l10n/app_localizations.dart';
import 'package:news_app/modules/all_cubits/app_setting/app_cubit.dart';
import 'package:news_app/modules/all_cubits/articals_cubit/articals_cubit.dart';
import 'package:news_app/modules/all_cubits/sources_cubit/sources_cubit.dart';
import 'package:news_app/modules/view/sceens/widgets/custom_drawer_widget.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ArticalsCubit()),
        BlocProvider(create: (context) => AppCubit()),
        BlocProvider(
          create: (context) => SourcesCubit(context.read<ArticalsCubit>()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        var currentCubit = context.read<AppCubit>();
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
            currentCubit.selectedLanguage == SelectedLanguage.en ? 'en' : 'ar',
          ),
          debugShowCheckedModeBanner: false,

          title: 'Flutter Demo',
          theme: ThemeManager.getLight(
            currentCubit.selectedLanguage == SelectedLanguage.en ? 'en' : 'ar',
          ),
          darkTheme: ThemeManager.getDark(
            currentCubit.selectedLanguage == SelectedLanguage.en ? 'en' : 'ar',
          ),
          themeMode: currentCubit.selectedTheme == SelectedTheme.dark
              ? ThemeMode.dark
              : ThemeMode.light,

          onGenerateRoute: AppRoute.onGenerateRoute,
        );
      },
    );
  }
}
