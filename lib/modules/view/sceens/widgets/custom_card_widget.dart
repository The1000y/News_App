import 'package:flutter/material.dart';
import 'package:news_app/core/themes/color_pallete.dart';
import 'package:news_app/models/categry_data_model.dart';

// ignore: must_be_immutable
class CustomCardWidget extends StatefulWidget {
  CustomCardWidget({
    super.key,
    required this.categoryModel,
    required this.isLeft,
    required this.onTap,
    required this.onSwap,
  });

  final CategoryDataModel categoryModel;
  final bool isLeft;
  final void Function() onTap;

  final void Function(CategoryDataModel categoryDataModel) onSwap;
  Offset offset = Offset(0, 0);
  @override
  State<CustomCardWidget> createState() => _CustomCardWidgetState();
}

class _CustomCardWidgetState extends State<CustomCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      width: double.infinity,
      height: 195,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        image: DecorationImage(
          image: AssetImage(widget.categoryModel.image),
          fit: BoxFit.cover,
        ),
      ),
      child: Directionality(
        textDirection: widget.isLeft ? TextDirection.ltr : TextDirection.rtl,

        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: widget.onTap,
              child: Container(
                margin: EdgeInsets.only(
                  bottom: 40,
                  left: widget.isLeft ? 150 : 0,
                  right: widget.isLeft ? 0 : 150,
                ),
                // margin: EdgeInsets.only(bottom: 40, left: 130),
                decoration: BoxDecoration(
                  color: ColorPallete.scafoldBackgroundColor.withValues(
                    alpha: 0.5,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(360)),
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
                    Transform.translate(
                      offset: widget.offset,
                      child: GestureDetector(
                        onHorizontalDragUpdate: (details) {
                          setState(
                            () {
                              widget.offset += details.delta;
                              // print(widget.offset);
                              if (widget.offset.dx > 60 ||
                                  widget.offset.dx < -60) {
                                widget.onSwap(widget.categoryModel);
                                widget.offset = Offset(0, 0);
                              }
                            },

                            // widget.onSwap(widget.categoryModel);
                            // offset = Offset(0, 0);
                          );
                        },
                        onHorizontalDragEnd: (details) {
                          setState(() {
                            if (widget.offset.dx < 60 ||
                                widget.offset.dx < -60) {
                              widget.offset = Offset(0, 0);
                            }
                          });
                          ;
                        },
                        child: CircleAvatar(
                          backgroundColor: ColorPallete.scafoldBackgroundColor,
                          radius: 30,
                          child: Icon(
                            Icons.arrow_back_ios_rounded,
                            color: ColorPallete.primaryDarkcolor,
                          ),
                        ),
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
