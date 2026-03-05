import 'package:flutter/material.dart';
import 'package:news_app/models/categry_data_model.dart';
import 'package:news_app/modules/view/sceens/widgets/custom_drawer_widget.dart';

class AppProvider extends ChangeNotifier {
  SelectedTheme selectedTheme = SelectedTheme.dark;
  SelectedLanguage selectedLanguage = SelectedLanguage.en;

  CategoryDataModel? selectedCategory;

  void onSelectedCategory(CategoryDataModel categoryDataModel) {
    selectedCategory = categoryDataModel;
    notifyListeners();
  }

  void onChangeTheme(SelectedTheme selectedTheme) {
    this.selectedTheme = selectedTheme;
    notifyListeners();
  }

  void clearCategory() {
    selectedCategory = null;
    notifyListeners();
  }

  void onChangeLanguage(SelectedLanguage selectedLanguage) {
    this.selectedLanguage = selectedLanguage;
    notifyListeners();
  }
}
