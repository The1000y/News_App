import 'package:flutter/material.dart';
import 'package:news_app/core/themes/color_pallete.dart';
import 'package:news_app/models/categry_data_model.dart';

class CustomCardWidget extends StatelessWidget {
  const CustomCardWidget({
    super.key,
    required this.categoryModel,
    required this.isLeft,
    required this.onTap,
  });

  final CategoryDataModel categoryModel;
  final bool isLeft;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      width: double.infinity,
      height: 195,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        image: DecorationImage(
          image: AssetImage(categoryModel.image),
          fit: BoxFit.cover,
        ),
      ),
      child: Directionality(
        textDirection: isLeft ? TextDirection.ltr : TextDirection.rtl,

        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: onTap,
              child: Container(
                margin: EdgeInsets.only(
                  bottom: 40,
                  left: isLeft ? 150 : 0,
                  right: isLeft ? 0 : 150,
                ),
                // margin: EdgeInsets.only(bottom: 40, left: 130),
                decoration: BoxDecoration(
                  color: ColorPallete.scafoldBackgroundColor.withValues(
                    alpha: 0.5,
                  ),
                  borderRadius: BorderRadius.circular(64),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        'View All',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: ColorPallete.scafoldBackgroundColor,
                      radius: 30,
                      child: Icon(
                        Icons.arrow_back_ios_rounded,
                        color: ColorPallete.primaryDarkcolor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
