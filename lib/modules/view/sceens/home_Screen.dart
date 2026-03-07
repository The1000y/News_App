import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/gen/assets.gen.dart';
// import 'package:news_app/core/provider/app_provider.dart';
import 'package:news_app/l10n/app_localizations.dart';
import 'package:news_app/models/categry_data_model.dart';
import 'package:news_app/modules/all_cubits/app_setting/app_cubit.dart';

import 'package:news_app/modules/view/sceens/widgets/category_news_data_view.dart';
import 'package:news_app/modules/view/sceens/widgets/custom_card_widget.dart';
import 'package:news_app/modules/view/sceens/widgets/custom_drawer_widget.dart';
// import 'package:provider/provider.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // SelectedTheme selectedTheme = SelectedTheme.dark;
  @override
  Widget build(BuildContext context) {
    var localization = AppLocalizations.of(context)!;
    List<CategoryDataModel> category = [
      CategoryDataModel(
        id: "general",
        name: localization.general,
        image: Assets.images.generalImage.path,
      ),
      CategoryDataModel(
        id: "business",
        name: localization.business,
        image: Assets.images.businessImage.path,
      ),
      CategoryDataModel(
        id: "sports",
        name: localization.sports,
        image: Assets.images.sportsImage.path,
      ),
      CategoryDataModel(
        id: "health",
        name: localization.health,
        image: Assets.images.healthImage.path,
      ),
      CategoryDataModel(
        id: "science",
        name: localization.science,
        image: Assets.images.scienceImage.path,
      ),
      CategoryDataModel(
        id: "technology",
        name: localization.technology,
        image: Assets.images.technologyImage.path,
      ),

      CategoryDataModel(
        id: "entertainment",
        name: localization.entertainment,
        image: Assets.images.entertinment.path,
      ),
    ];
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        var myTheme = Theme.of(context);
        var currentCubit = context.read<AppCubit>();

        return Scaffold(
          appBar: AppBar(
            //////////////////////
            iconTheme: IconThemeData(color: myTheme.primaryColorDark),
            title: currentCubit.selectedCategory == null
                ? Text(localization.news, style: myTheme.textTheme.titleSmall)
                : Text(
                    currentCubit.selectedCategory!.name,
                    style: myTheme.textTheme.titleSmall,
                  ),
            actions: [
              IconButton(
                onPressed: () {},
                ///////////////////////////
                icon: Assets.icons.search.svg(color: myTheme.primaryColorDark),
              ),
            ],
          ),
          drawer: CustomDrawerWidget(
            language: currentCubit.selectedLanguage,
            onLanguageChange: currentCubit.onChangeLanguage,
            onThemeChange: currentCubit.onChangeTheme,
            theme: currentCubit.selectedTheme,
            onTap: () {
              currentCubit.clearCategory();
              Navigator.pop(context);
            },
          ),

          body: currentCubit.selectedCategory == null
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${localization.good_morning} \n${localization.here_is_some_news_for_you}",
                          style: myTheme.textTheme.titleMedium,
                        ),
                        SizedBox(height: 16),
                        ...List.generate(category.length, (index) {
                          return CustomCardWidget(
                            onSwap: (categoryDataModel) {
                              currentCubit.onSelectedCategory(category[index]);
                            },
                            onTap: () {
                              currentCubit.onSelectedCategory(category[index]);
                            },
                            categoryModel: category[index],
                            isLeft: index % 2 == 0,
                          );
                        }),
                      ],
                    ),
                  ),
                )
              : CategoryNewsDataView(
                  categoryDataModel: currentCubit.selectedCategory!,
                ),
        );
      },
    );
  }
}
