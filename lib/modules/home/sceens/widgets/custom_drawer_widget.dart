import 'package:flutter/material.dart';
import 'package:news_app/core/gen/assets.gen.dart';
import 'package:news_app/core/themes/color_pallete.dart';

// ignore: must_be_immutable
class CustomDrawerWidget extends StatelessWidget {
  const CustomDrawerWidget({super.key, required this.onTap});

  final VoidCallback onTap;
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
              onTap: onTap,
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
          ],
        ),
      ),
    );
  }
}
