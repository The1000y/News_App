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
    var myTheme = Theme.of(context);

    return Container(
      margin: EdgeInsets.only(bottom: 16),
      width: double.infinity,
      height: 195,
      decoration: BoxDecoration(
        color: myTheme.primaryColorDark,
        borderRadius: BorderRadius.circular(24),
        image: DecorationImage(
          image: AssetImage(widget.categoryModel.image),
          alignment: widget.isLeft ? Alignment.topLeft : Alignment.topRight,
          fit: BoxFit.scaleDown,
        ),
      ),
      child: Directionality(
        textDirection: widget.isLeft ? TextDirection.ltr : TextDirection.rtl,

        child: Column(
          spacing: 30,
          mainAxisAlignment: MainAxisAlignment.end,

          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 68),
              child: Align(
                alignment: widget.isLeft
                    ? Alignment.topRight
                    : Alignment.topLeft,
                child: Text(
                  widget.categoryModel.name,
                  style: myTheme.textTheme.titleLarge,
                ),
              ),
            ),
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
                  color: AppColors.grayColor.withValues(alpha: 0.8),
                  borderRadius: BorderRadius.all(Radius.circular(360)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'View All',
                        style: myTheme.textTheme.titleSmall!.copyWith(
                          color: AppColors.darkColor,
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
                        },
                        child: CircleAvatar(
                          backgroundColor: myTheme.primaryColorLight,
                          radius: 30,
                          child: Icon(
                            Icons.arrow_back_ios_rounded,
                            color: myTheme.primaryColorDark,
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
