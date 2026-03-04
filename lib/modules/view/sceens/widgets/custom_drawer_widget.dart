import 'package:flutter/material.dart';
import 'package:news_app/core/gen/assets.gen.dart';
import 'package:news_app/core/provider/app_provider.dart';
import 'package:news_app/core/themes/color_pallete.dart';
import 'package:provider/provider.dart';

enum SelectedTheme { dark, ligth }

// ignore: must_be_immutable
class CustomDrawerWidget extends StatelessWidget {
  CustomDrawerWidget({
    super.key,
    required this.onTap,
    required this.theme,
    required this.onThemeChange,
  });

  final VoidCallback onTap;
  final SelectedTheme theme;
  Function(SelectedTheme theme) onThemeChange;

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, provider, child) {
        var myTheme = Theme.of(context);

        return Drawer(
          width: MediaQuery.of(context).size.width * 0.70,
          child: Container(
            decoration: const BoxDecoration(color: AppColors.darkColor),
            child: Column(
              children: [
                Container(
                  height: 166,
                  width: double.infinity,
                  decoration: BoxDecoration(color: AppColors.whiteColor),
                  child: Center(
                    child: Text(
                      'News App',
                      style: myTheme.textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.darkColor,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      spacing: 10,
                      children: [
                        Assets.icons.home.svg(color: AppColors.whiteColor),
                        Text(
                          'Go to Home',
                          style: myTheme.textTheme.titleLarge!.copyWith(
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(thickness: 2, endIndent: 20, indent: 20),
                headerTitle(icon: Assets.icons.theme, title: 'Theme'),

                //menu of theme
                PopupMenuButton<SelectedTheme>(
                  onSelected: (value) {
                    onThemeChange(value);
                  },
                  offset: Offset(60, 50),
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        value: SelectedTheme.dark,
                        child: Text('Dark'),
                      ),
                      PopupMenuItem(
                        value: SelectedTheme.ligth,
                        child: Text('Light'),
                      ),
                    ];
                  },
                  child: CustomContainer(
                    title: theme == SelectedTheme.dark ? 'Dark' : 'Light',
                  ),
                ),
                SizedBox(height: 25),
                Divider(thickness: 2, endIndent: 20, indent: 20),
                headerTitle(icon: Assets.icons.earth, title: 'Language'),

                //menu of language
                PopupMenuButton(
                  offset: Offset(60, 50),
                  onSelected: (value) {
                    selectedLanguage = value;
                  },
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(value: 'English', child: Text('English')),
                      PopupMenuItem(value: 'Arabic', child: Text('Arabic')),
                    ];
                  },
                  child: CustomContainer(title: selectedLanguage),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // String selectedTheme = 'Dark';
  String selectedLanguage = 'English';
}

class CustomContainer extends StatelessWidget {
  const CustomContainer({required this.title, super.key});
  final String title;

  @override
  Widget build(BuildContext context) {
    var myTheme = Theme.of(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: AppColors.whiteColor, width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              title,
              style: myTheme.textTheme.titleMedium!.copyWith(
                color: AppColors.whiteColor,
              ),
            ),
          ),
          Icon(
            Icons.arrow_drop_down_rounded,
            size: 40,
            color: AppColors.whiteColor,
          ),
        ],
      ),
    );
  }
}

class headerTitle extends StatelessWidget {
  const headerTitle({super.key, required this.title, required this.icon});
  final String title;
  final SvgGenImage icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        spacing: 10,
        children: [
          icon.svg(color: AppColors.whiteColor),
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.whiteColor,
            ),
          ),
        ],
      ),
    );
  }
}
