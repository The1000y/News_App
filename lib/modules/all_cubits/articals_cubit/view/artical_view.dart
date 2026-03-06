import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/themes/color_pallete.dart';
import 'package:news_app/modules/all_cubits/articals_cubit/articals_cubit.dart';
import 'package:news_app/modules/all_cubits/sources_cubit/sources_cubit.dart';
import 'package:news_app/modules/all_cubits/sources_cubit/sources_state.dart';
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
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: AppColors.darkColor,
                                  width: 1,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CachedNetworkImage(
                                    imageUrl:
                                        listArtical[index].urlToImage ?? "",
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                          margin: EdgeInsets.all(8),
                                          height: 220,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
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
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        SizedBox(
                                          height: 220,
                                          width: double.infinity,
                                          child: Icon(Icons.error),
                                        ),
                                  ),
                                  // Container(
                                  //   margin: EdgeInsets.all(8),
                                  //   height: 220,
                                  //   width: double.infinity,
                                  //   decoration: BoxDecoration(
                                  //     borderRadius: BorderRadius.circular(8),

                                  //     // image: DecorationImage(
                                  //     //   fit: BoxFit.cover,
                                  //     //   image: Image.network(
                                  //     //     listArticals[index].urlToImage ??
                                  //     //         "",
                                  //     //   ).image,
                                  //     // ),
                                  //   ),
                                  // ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                    ),
                                    child: Text(
                                      listArtical[index].title ?? "no title",
                                      style: myTheme.textTheme.bodyLarge,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            listArtical[index].author ?? "",
                                            style: myTheme.textTheme.bodySmall,
                                          ),
                                        ),
                                        Text(
                                          listArtical[index].publishedAt ?? "",
                                          style: myTheme.textTheme.bodySmall,
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
                        itemCount: listArtical.length,
                      ),
                    );
          }

          // var currentCubit = context.read<ArticalsCubit>();
        },
      ),
    );
  }
}
