import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/themes/color_pallete.dart';
import 'package:news_app/l10n/app_localizations.dart';
import 'package:news_app/models/data/article.articals.model.dart';
import 'package:news_app/modules/all_cubits/app_setting/app_cubit.dart';
import 'package:news_app/modules/all_cubits/articals_cubit/articals_cubit.dart';
import 'package:news_app/modules/all_cubits/sources_cubit/sources_cubit.dart';
import 'package:news_app/modules/all_cubits/sources_cubit/sources_state.dart';
import 'package:news_app/modules/view/sceens/widgets/artical_widget.dart';
import 'package:news_app/modules/view/sceens/widgets/category_news_data_view.dart';

class ArticalView extends StatelessWidget {
  const ArticalView({super.key, required this.widget, required this.myTheme});

  final CategoryNewsDataView widget;
  final ThemeData myTheme;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SourcesCubit, SourcesState>(
      listener: (context, state) {
        if (state is SuccessGetAllSources) {
          context.read<ArticalsCubit>().getArticals(
            widget.categoryDataModel.id,
          );
        }
      },
      child: BlocBuilder<ArticalsCubit, ArticalsState>(
        builder: (context, state) {
          switch (state) {
            case ArticalsInitial():
              return const Center(child: Text('Initial State'));
            case LoadingGetArtical():
              return const Center(child: CircularProgressIndicator());
            case ErrorGetArtical():
              return const Center(child: Text('Error'));
            case SuccessGetArtical():
              var listArtical = state.listArtical;
              return listArtical!.isEmpty
                  ? Center(
                      child: Text(
                        'Empty Data!!',
                        style: TextStyle(
                          color: AppColors.whiteColor,
                          fontSize: 20,
                        ),
                      ),
                    )
                  : Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: InkWell(
                              onTap: () {
                                bottomSheet(context, listArtical[index]);
                              },
                              child: ArticalWidget(
                                index: index,
                                listArtical: listArtical,
                                myTheme: myTheme,
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 8);
                        },
                        itemCount: listArtical.length,
                      ),
                    );
          }

          // var currentCubit = context.read<ArticalsCubit>();
        },
      ),
    );
  }

  Future<dynamic> bottomSheet(BuildContext context, Artical myArtical) {
    var myCubit = context.read<AppCubit>();
    var myLocalization = AppLocalizations.of(context)!;
    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        var hight = MediaQuery.of(context).size.height;
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 12, vertical: 18),
          constraints: BoxConstraints(maxHeight: hight * 0.6),
          decoration: BoxDecoration(
            color: myCubit.isDark ? AppColors.whiteColor : AppColors.darkColor,
            borderRadius: BorderRadius.all(Radius.circular(24)),
          ),
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CachedNetworkImage(
                  imageUrl: myArtical.urlToImage ?? "",
                  imageBuilder: (context, imageProvider) => Container(
                    margin: EdgeInsets.all(4),
                    height: 220,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                        // colorFilter: ColorFilter.mode(
                        //   Colors.red,
                        //   BlendMode.colorBurn,
                        // ),
                      ),
                    ),
                  ),
                  placeholder: (context, url) => SizedBox(
                    height: 220,
                    width: double.infinity,
                    child: Center(child: CircularProgressIndicator()),
                  ),
                  errorWidget: (context, url, error) => SizedBox(
                    height: 220,
                    width: double.infinity,
                    child: Icon(Icons.error),
                  ),
                ),

                // Container(
                //   width: double.infinity,
                //   height: 220,

                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.all(Radius.circular(12)),
                //     image: DecorationImage(
                //       fit: BoxFit.cover,
                //       image: NetworkImage(myArtical.urlToImage ?? ""),
                //     ),
                //   ),
                // ),
                SizedBox(height: 8),

                Text(
                  myArtical.content ?? "",
                  style: myCubit.isDark
                      ? myTheme.textTheme.bodyLarge!.copyWith(
                          color: AppColors.darkColor,
                        )
                      : myTheme.textTheme.bodyLarge!.copyWith(
                          color: AppColors.whiteColor,
                        ),
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: () {},
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        myLocalization.view_full_articel,
                        style: myTheme.textTheme.titleMedium,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // decoration: BoxDecoration(
          //   borderRadius: ,
          //   image: DecorationImage(image: AssetImage(Assets.images.a40YersOld.path))
          // ),
        );
      },
    );
  }
}
