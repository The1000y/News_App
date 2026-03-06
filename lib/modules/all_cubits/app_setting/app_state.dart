part of 'app_cubit.dart';

@immutable
sealed class AppState {}

final class AppInitial extends AppState {}

class SucessSelectedCategory extends AppState {
  SucessSelectedCategory();
}

class SucessChangeTheme extends AppState {
  SucessChangeTheme();
}

class SucessChangeLanguage extends AppState {
  SucessChangeLanguage();
}

class SucessClearCategory extends AppState {
  SucessClearCategory();
}
