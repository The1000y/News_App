import 'package:flutter/material.dart';
import 'package:news_app/core/gen/assets.gen.dart';
import 'package:news_app/models/gategry_data_model.dart';
import 'package:news_app/modules/home/sceens/widgets/custom_card_widget.dart';
import 'package:news_app/modules/home/sceens/widgets/custom_drawer_widget.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    List<CategoryDataModel> category = [
      CategoryDataModel(
        id: "general",
        name: "General",
        image: Assets.images.general.path,
      ),
      CategoryDataModel(
        id: "business",
        name: "Business",
        image: Assets.images.business.path,
      ),
      CategoryDataModel(
        id: "sports",
        name: "Sports",
        image: Assets.images.sports.path,
      ),
      CategoryDataModel(
        id: "health",
        name: "Health",
        image: Assets.images.health.path,
      ),
      CategoryDataModel(
        id: "science",
        name: "Science",
        image: Assets.images.science.path,
      ),
      CategoryDataModel(
        id: "technology",
        name: "Technology",
        image: Assets.images.technology.path,
      ),

      CategoryDataModel(
        id: "entertainment",
        name: "Entertainment",
        image: Assets.images.entertainment.path,
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        title: selectedCategory == null
            ? Text('News', style: TextStyle(fontSize: 25))
            : Text(selectedCategory!.name, style: TextStyle(fontSize: 25)),
        actions: [
          IconButton(onPressed: () {}, icon: Assets.icons.search.svg()),
        ],
      ),
      drawer: CustomDrawerWidget(
        onTap: () {
          setState(() {
            selectedCategory = null;
            Navigator.pop(context);
          });
        },
      ),

      body: selectedCategory == null
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Good Morning ... \nHere is Some News For You",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 16),
                    ...List.generate(category.length, (index) {
                      return CustomCardWidget(
                        onTap: () {
                          onSelectedCategory(category[index]);
                        },
                        categoryModel: category[index],
                        isLeft: index % 2 == 0,
                      );
                    }),
                  ],
                ),
              ),
            )
          : SizedBox(),
    );
  }

  CategoryDataModel? selectedCategory;

  void onSelectedCategory(CategoryDataModel categoryDataModel) {
    setState(() {
      selectedCategory = categoryDataModel;
    });
  }
}
