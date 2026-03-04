import 'package:flutter/material.dart';
import 'package:news_app/core/gen/assets.gen.dart';
import 'package:news_app/core/provider/app_provider.dart';
import 'package:news_app/models/categry_data_model.dart';
import 'package:news_app/modules/view/sceens/widgets/category_news_data_view.dart';
import 'package:news_app/modules/view/sceens/widgets/custom_card_widget.dart';
import 'package:news_app/modules/view/sceens/widgets/custom_drawer_widget.dart';
import 'package:news_app/modules/view_model/home_view_model.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  // SelectedTheme selectedTheme = SelectedTheme.dark;

  @override
  Widget build(BuildContext context) {
    List<CategoryDataModel> category = [
      CategoryDataModel(
        id: "general",
        name: "General",
        image: Assets.images.generalImage.path,
      ),
      CategoryDataModel(
        id: "business",
        name: "Business",
        image: Assets.images.businessImage.path,
      ),
      CategoryDataModel(
        id: "sports",
        name: "Sports",
        image: Assets.images.sportsImage.path,
      ),
      CategoryDataModel(
        id: "health",
        name: "Health",
        image: Assets.images.healthImage.path,
      ),
      CategoryDataModel(
        id: "science",
        name: "Science",
        image: Assets.images.scienceImage.path,
      ),
      CategoryDataModel(
        id: "technology",
        name: "Technology",
        image: Assets.images.technologyImage.path,
      ),

      CategoryDataModel(
        id: "entertainment",
        name: "Entertainment",
        image: Assets.images.entertinment.path,
      ),
    ];
    return ChangeNotifierProvider(
      create: (context) => HomeViewModel(),
      child: Consumer<AppProvider>(
        builder: (context, provider, child) {
          var myTheme = Theme.of(context);

          return Scaffold(
            appBar: AppBar(
              //////////////////////
              iconTheme: IconThemeData(color: myTheme.primaryColorDark),
              title: provider.selectedCategory == null
                  ? Text('News', style: myTheme.textTheme.titleSmall)
                  : Text(
                      provider.selectedCategory!.name,
                      style: myTheme.textTheme.titleSmall,
                    ),
              actions: [
                IconButton(
                  onPressed: () {},
                  ///////////////////////////
                  icon: Assets.icons.search.svg(
                    color: myTheme.primaryColorDark,
                  ),
                ),
              ],
            ),
            drawer: CustomDrawerWidget(
              onThemeChange: provider.onChangeTheme,
              theme: provider.selectedTheme,
              onTap: () {
                provider.selectedCategory = null;
                Navigator.pop(context);
              },
            ),

            body: provider.selectedCategory == null
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Good Morning ... \nHere is Some News For You",
                            style: myTheme.textTheme.titleMedium,
                          ),
                          SizedBox(height: 16),
                          ...List.generate(category.length, (index) {
                            return CustomCardWidget(
                              onSwap: (categoryDataModel) {
                                provider.onSelectedCategory(category[index]);
                              },
                              onTap: () {
                                provider.onSelectedCategory(category[index]);
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
                    categoryDataModel: provider.selectedCategory!,
                  ),
          );
        },
      ),
    );
  }
}
