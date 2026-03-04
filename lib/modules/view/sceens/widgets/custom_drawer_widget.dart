import 'package:flutter/material.dart';
import 'package:news_app/core/gen/assets.gen.dart';
import 'package:news_app/core/themes/color_pallete.dart';

// ignore: must_be_immutable
class CustomDrawerWidget extends StatefulWidget {
  CustomDrawerWidget({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  State<CustomDrawerWidget> createState() => _CustomDrawerWidgetState();
  String selectedTheme = 'Dark';
  String selectedLanguage = 'English';
}

class _CustomDrawerWidgetState extends State<CustomDrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.70,
      child: Container(
        decoration: const BoxDecoration(color: ColorPallete.primaryDarkcolor),
        child: Column(
          children: [
            Container(
              height: 166,
              width: double.infinity,
              decoration: BoxDecoration(
                color: ColorPallete.scafoldBackgroundColor,
              ),
              child: Center(
                child: Text(
                  'News App',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            GestureDetector(
              onTap: widget.onTap,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  spacing: 10,
                  children: [
                    Assets.icons.home.svg(
                      color: ColorPallete.scafoldBackgroundColor,
                    ),
                    Text(
                      'Go to Home',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: ColorPallete.scafoldBackgroundColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(thickness: 2, endIndent: 20, indent: 20),
            headerTitle(icon: Assets.icons.theme, title: 'Theme'),

            //menu of theme
            PopupMenuButton<String>(
              onSelected: (value) {
                print(value);
                widget.selectedTheme = value;
                setState(() {});
              },
              offset: Offset(60, 50),
              itemBuilder: (context) {
                return [
                  PopupMenuItem<String>(value: 'Dark', child: Text('Dark')),
                  PopupMenuItem<String>(value: 'Light', child: Text('Light')),
                ];
              },
              child: CustomContainer(title: widget.selectedTheme),
            ),
            SizedBox(height: 25),
            Divider(thickness: 2, endIndent: 20, indent: 20),
            headerTitle(icon: Assets.icons.earth, title: 'Language'),

            //menu of language
            PopupMenuButton(
              offset: Offset(60, 50),
              onSelected: (value) {
                widget.selectedLanguage = value;
                setState(() {});
              },
              itemBuilder: (context) {
                return [
                  PopupMenuItem(value: 'English', child: Text('English')),
                  PopupMenuItem(value: 'Arabic', child: Text('Arabic')),
                ];
              },
              child: CustomContainer(title: widget.selectedLanguage),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomContainer extends StatelessWidget {
  const CustomContainer({required this.title, super.key});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        border: Border.all(
          color: ColorPallete.scafoldBackgroundColor,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 18,
                color: ColorPallete.scafoldBackgroundColor,
              ),
            ),
          ),
          Icon(
            Icons.arrow_drop_down_rounded,
            size: 40,
            color: ColorPallete.scafoldBackgroundColor,
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
          icon.svg(color: ColorPallete.scafoldBackgroundColor),
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: ColorPallete.scafoldBackgroundColor,
            ),
          ),
        ],
      ),
    );
  }
}
