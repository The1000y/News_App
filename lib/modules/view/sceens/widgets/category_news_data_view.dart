import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/core/themes/color_pallete.dart';
import 'package:news_app/models/categry_data_model.dart';
import 'package:news_app/modules/cubit/home_view_model.dart';
import 'package:provider/provider.dart';

class CategoryNewsDataView extends StatefulWidget {
  final CategoryDataModel categoryDataModel;
  const CategoryNewsDataView({super.key, required this.categoryDataModel});

  @override
  State<CategoryNewsDataView> createState() => _CategoryNewsDataViewState();
}

class _CategoryNewsDataViewState extends State<CategoryNewsDataView> {
  // late Future<List<SourceData>> sourcesFuture;
  late HomeViewModel homeViewModel;
  @override
  void initState() {
    // sourcesFuture = NetworkHandler.getSources(widget.categoryDataModel.id);
    if (mounted) {
      homeViewModel = Provider.of<HomeViewModel>(context, listen: false);
    }
    Future.wait([homeViewModel.getSources(widget.categoryDataModel.id)]).then((
      value,
    ) {
      if (homeViewModel.listData.isNotEmpty) {
        homeViewModel.getArticals(
          homeViewModel.listData[homeViewModel.selectedTapIndex].id,
        );
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var myTheme = Theme.of(context);
    return Column(
      children: [
        SizedBox(height: 8),
        Consumer<HomeViewModel>(
          builder: (context, provider, child) {
            // if (provider.listData.isEmpty) {
            //   return Center(child: CircularProgressIndicator());
            // }
            return DefaultTabController(
              length: provider.listData.length,
              child: TabBar(
                padding: EdgeInsets.symmetric(horizontal: 16),
                tabAlignment: TabAlignment.start,
                overlayColor: WidgetStatePropertyAll(Colors.transparent),
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorColor: AppColors.darkColor,
                dividerColor: Colors.transparent,
                physics: BouncingScrollPhysics(),
                onTap: (index) {
                  provider.onTap(index);
                },

                // labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                isScrollable: true,
                tabs: List.generate(provider.listData.length, (index) {
                  bool isSelected = provider.selectedTapIndex == index;
                  return Text(
                    provider.listData[index].name,
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
          },
        ),
        SizedBox(height: 12),
        Consumer<HomeViewModel>(
          builder: (context, nextProvider, child) {
            if (nextProvider.listArtical == null) {
              return Center(child: CircularProgressIndicator());
            } else if (nextProvider.listArtical!.isEmpty) {
              return Center(child: Text("No Data Found"));
            }
            return Expanded(
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
                        children: [
                          CachedNetworkImage(
                            imageUrl:
                                nextProvider.listArtical![index].urlToImage ??
                                "",
                            imageBuilder: (context, imageProvider) => Container(
                              margin: EdgeInsets.all(8),
                              height: 220,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
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
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              nextProvider.listArtical![index].title ??
                                  "no title",
                              style: myTheme.textTheme.bodyLarge,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    nextProvider.listArtical![index].author ??
                                        "",
                                    style: myTheme.textTheme.bodySmall,
                                  ),
                                ),
                                Text(
                                  nextProvider
                                          .listArtical![index]
                                          .publishedAt ??
                                      "",
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
                itemCount: nextProvider.listArtical!.length,
              ),
            );
          },
        ),

        SizedBox(height: 8),
      ],
    );
  }
}
