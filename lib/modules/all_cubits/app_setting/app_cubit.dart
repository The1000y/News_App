import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:news_app/models/categry_data_model.dart';
import 'package:news_app/modules/view/sceens/widgets/custom_drawer_widget.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  //////////////////////////////////////////////////////
  // TODO: theme and language
  //////////////////////////////////////////////////////

  SelectedTheme selectedTheme = SelectedTheme.dark;
  SelectedLanguage selectedLanguage = SelectedLanguage.en;

  bool get isDark => selectedTheme == SelectedTheme.dark;

  CategoryDataModel? selectedCategory;

  void onSelectedCategory(CategoryDataModel categoryDataModel) {
    selectedCategory = categoryDataModel;
    emit(SucessSelectedCategory());
  }

  void onChangeTheme(SelectedTheme selectedTheme) {
    this.selectedTheme = selectedTheme;
    emit(SucessChangeTheme());
  }

  void clearCategory() {
    selectedCategory = null;
    emit(SucessClearCategory());
  }

  void onChangeLanguage(SelectedLanguage selectedLanguage) {
    this.selectedLanguage = selectedLanguage;
    emit(SucessChangeLanguage());
  }
}
