import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/themes/color_pallete.dart';
import 'package:news_app/models/categry_data_model.dart';
import 'package:news_app/modules/all_cubits/articals_cubit/articals_cubit.dart';
import 'package:news_app/modules/all_cubits/sources_cubit/sources_cubit.dart';
import 'package:news_app/modules/all_cubits/sources_cubit/sources_state.dart';

class CategoryNewsDataView extends StatefulWidget {
  final CategoryDataModel categoryDataModel;
  const CategoryNewsDataView({super.key, required this.categoryDataModel});

  @override
  State<CategoryNewsDataView> createState() => _CategoryNewsDataViewState();
}

class _CategoryNewsDataViewState extends State<CategoryNewsDataView> {
  // late Future<List<SourceData>> sourcesFuture;

  @override
  void initState() {
    // sourcesFuture = NetworkHandler.getSources(widget.categoryDataModel.id);

    Future.wait([
      context.read<SourcesCubit>().getSources(widget.categoryDataModel.id),
    ]).then((value) {
      context.read<ArticalsCubit>().getArticals(widget.categoryDataModel.id);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var myTheme = Theme.of(context);
    var currentCubit = context.read<SourcesCubit>();

    return Column(
      children: [
        SizedBox(height: 8),
        BlocBuilder<SourcesCubit, SourcesState>(
          builder: (context, state) {
            switch (state) {
              case LoadingGetAllSources():
                return const Center(child: CircularProgressIndicator());

              case HomeInitialState():
                return const Center(child: Text('Initial State'));

              case ErrorGetAllSources():
                return const Center(child: Text('Error'));

              case SuccessGetAllSources():
                var sourcesList = state.listSources;
                return DefaultTabController(
                  length: sourcesList.length,
                  child: TabBar(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    tabAlignment: TabAlignment.start,
                    overlayColor: WidgetStatePropertyAll(Colors.transparent),
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorColor: AppColors.darkColor,
                    dividerColor: Colors.transparent,
                    physics: BouncingScrollPhysics(),
                    onTap: (index) {
                      currentCubit.onTap(index);
                    },

                    // labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                    isScrollable: true,
                    tabs: List.generate(sourcesList.length, (index) {
                      bool isSelected = currentCubit.selectedTapIndex == index;
                      return Text(
                        sourcesList[index].name,
                        style: TextStyle(
                          fontSize: isSelected ? 18 : 16,
                          fontWeight: isSelected
                              ? FontWeight.w800
                              : FontWeight.w400,
                          color: myTheme.primaryColorDark,
                        ),
                      );
                    }),
                  ),
                );

              case changeIndexState():
                return DefaultTabController(
                  length: currentCubit.listSources.length,
                  child: TabBar(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    tabAlignment: TabAlignment.start,
                    overlayColor: WidgetStatePropertyAll(Colors.transparent),
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorColor: AppColors.darkColor,
                    dividerColor: Colors.transparent,
                    physics: BouncingScrollPhysics(),
                    onTap: (index) {
                      currentCubit.onTap(index);
                    },

                    // labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                    isScrollable: true,
                    tabs: List.generate(currentCubit.listSources.length, (
                      index,
                    ) {
                      bool isSelected = currentCubit.selectedTapIndex == index;
                      return Text(
                        currentCubit.listSources[index].name,
                        style: TextStyle(
                          fontSize: isSelected ? 18 : 16,
                          fontWeight: isSelected
                              ? FontWeight.w800
                              : FontWeight.w400,
                          color: myTheme.primaryColorDark,
                        ),
                      );
                    }),
                  ),
                );
            }
          },
        ),
        SizedBox(height: 12),

        // BlocBuilder<ArticalsCubit, ArticalsState>(
        //   builder: (context, state) {
        //     if (state is LoadingGetArtical) {
        //       return Center(child: CircularProgressIndicator());
        //     }
        //     if (state is ErrorGetArtical) {
        //       return Center(child: Text("Error"));
        //     }

        //     // var currentCubit = context.read<ArticalsCubit>();

        //     if (state is SuccessGetArtical) {
        //       var listArtical = state.listArtical;
        //       return Expanded(
        //         child: ListView.separated(
        //           itemBuilder: (context, index) {
        //             return Padding(
        //               padding: const EdgeInsets.symmetric(horizontal: 16),
        //               child: Container(
        //                 decoration: BoxDecoration(
        //                   borderRadius: BorderRadius.circular(8),
        //                   border: Border.all(
        //                     color: AppColors.darkColor,
        //                     width: 1,
        //                   ),
        //                 ),
        //                 child: Column(
        //                   crossAxisAlignment: CrossAxisAlignment.start,
        //                   children: [
        //                     CachedNetworkImage(
        //                       imageUrl:
        //                           listArtical[index].urlToImage ??
        //                           "",
        //                       imageBuilder: (context, imageProvider) =>
        //                           Container(
        //                             margin: EdgeInsets.all(8),
        //                             height: 220,
        //                             width: double.infinity,
        //                             decoration: BoxDecoration(
        //                               borderRadius: BorderRadius.circular(8),
        //                               image: DecorationImage(
        //                                 image: imageProvider,
        //                                 fit: BoxFit.cover,
        //                                 // colorFilter: ColorFilter.mode(
        //                                 //   Colors.red,
        //                                 //   BlendMode.colorBurn,
        //                                 // ),
        //                               ),
        //                             ),
        //                           ),
        //                       placeholder: (context, url) => SizedBox(
        //                         height: 220,
        //                         width: double.infinity,
        //                         child: Center(
        //                           child: CircularProgressIndicator(),
        //                         ),
        //                       ),
        //                       errorWidget: (context, url, error) => SizedBox(
        //                         height: 220,
        //                         width: double.infinity,
        //                         child: Icon(Icons.error),
        //                       ),
        //                     ),
        //                     // Container(
        //                     //   margin: EdgeInsets.all(8),
        //                     //   height: 220,
        //                     //   width: double.infinity,
        //                     //   decoration: BoxDecoration(
        //                     //     borderRadius: BorderRadius.circular(8),

        //                     //     // image: DecorationImage(
        //                     //     //   fit: BoxFit.cover,
        //                     //     //   image: Image.network(
        //                     //     //     listArticals[index].urlToImage ??
        //                     //     //         "",
        //                     //     //   ).image,
        //                     //     // ),
        //                     //   ),
        //                     // ),
        //                     Padding(
        //                       padding: const EdgeInsets.symmetric(
        //                         horizontal: 8,
        //                       ),
        //                       child: Text(
        //                        listArtical[index].title ??
        //                             "no title",
        //                         style: myTheme.textTheme.bodyLarge,
        //                       ),
        //                     ),
        //                     Padding(
        //                       padding: const EdgeInsets.all(8),
        //                       child: Row(
        //                         mainAxisAlignment:
        //                             MainAxisAlignment.spaceBetween,
        //                         children: [
        //                           Expanded(
        //                             child: Text(
        //                               maxLines: 2,
        //                               overflow: TextOverflow.ellipsis,
        //                              listArtical[index].author ??
        //                                   "",
        //                               style: myTheme.textTheme.bodySmall,
        //                             ),
        //                           ),
        //                           Text(
        //                            listArtical[index]
        //                                     .publishedAt ??
        //                                 "",
        //                             style: myTheme.textTheme.bodySmall,
        //                           ),
        //                         ],
        //                       ),
        //                     ),
        //                   ],
        //                 ),
        //               ),
        //             );
        //           },
        //           separatorBuilder: (context, index) {
        //             return SizedBox(height: 8);
        //           },
        //           itemCount:listArtical!.length,
        //         ),
        //       );
        //     }
        //     return const SizedBox.shrink();
        //   },
        // ),
        SizedBox(height: 8),
      ],
    );
  }
}
