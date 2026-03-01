import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/core/themes/color_pallete.dart';

class CategoryNewsDataView extends StatefulWidget {
  const CategoryNewsDataView({super.key});

  @override
  State<CategoryNewsDataView> createState() => _CategoryNewsDataViewState();
}

class _CategoryNewsDataViewState extends State<CategoryNewsDataView> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 8),
        DefaultTabController(
          length: 8,
          child: TabBar(
            padding: EdgeInsets.symmetric(horizontal: 16),
            tabAlignment: TabAlignment.start,
            overlayColor: WidgetStatePropertyAll(Colors.transparent),
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorColor: ColorPallete.primaryDarkcolor,
            dividerColor: Colors.transparent,
            physics: BouncingScrollPhysics(),
            onTap: (index) {
              setState(() {
                selectedIndex = index;
              });
            },

            // labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
            isScrollable: true,
            tabs: List.generate(8, (index) {
              bool isSelected = selectedIndex == index;
              return Text(
                'Tab ${index + 1}',
                style: TextStyle(
                  fontSize: isSelected ? 18 : 16,
                  fontWeight: isSelected ? FontWeight.w800 : FontWeight.w400,
                  color: ColorPallete.primaryDarkcolor,
                ),
              );
            }),
          ),
        ),
        SizedBox(height: 8),
        Expanded(
          child: ListView.separated(
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: ColorPallete.primaryDarkcolor,
                      width: 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.all(8),
                        height: 220,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/images/40-yers-old.png'),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          '40-year-old man falls 200 feet to his death while canyoneering at national park',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'By : Jon Haworth',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.withValues(alpha: 0.8),
                              ),
                            ),
                            Text(
                              '15 minutes ago',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.withValues(alpha: 0.8),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(height: 8);
            },
            itemCount: 5,
          ),
        ),
      ],
    );
  }
}
