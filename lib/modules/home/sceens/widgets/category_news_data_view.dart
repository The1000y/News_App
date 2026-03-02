import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/core/themes/color_pallete.dart';
import 'package:news_app/models/categry_data_model.dart';
import 'package:news_app/models/data/article.articals.model.dart';
import 'package:news_app/models/source_data_model.dart';
import 'package:news_app/network_handler/network_handler.dart';

class CategoryNewsDataView extends StatefulWidget {
  final CategoryDataModel categoryDataModel;
  const CategoryNewsDataView({super.key, required this.categoryDataModel});

  @override
  State<CategoryNewsDataView> createState() => _CategoryNewsDataViewState();
}

class _CategoryNewsDataViewState extends State<CategoryNewsDataView> {
  int selectedIndex = 0;
  late Future<List<SourceData>> sourcesFuture;
  @override
  void initState() {
    sourcesFuture = NetworkHandler.getSources(widget.categoryDataModel.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 8),
        Expanded(
          child: FutureBuilder(
            future: sourcesFuture,
            builder: (context, snapshot) {
              List<SourceData> listData = snapshot.data ?? [];
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: CircularProgressIndicator());
              }

              return Column(
                children: [
                  DefaultTabController(
                    length: listData.length,
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
                      tabs: List.generate(listData.length, (index) {
                        bool isSelected = selectedIndex == index;
                        return Text(
                          listData[index].name,
                          style: TextStyle(
                            fontSize: isSelected ? 18 : 16,
                            fontWeight: isSelected
                                ? FontWeight.w800
                                : FontWeight.w400,
                            color: ColorPallete.primaryDarkcolor,
                          ),
                        );
                      }),
                    ),
                  ),
                  SizedBox(height: 12),
                  FutureBuilder(
                    future: NetworkHandler.getArtical(
                      listData[selectedIndex].id,
                    ),
                    builder: (context, snapshot) {
                      List<Article> listArticals = snapshot.data ?? [];
                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(child: Text('No Data Here'));
                      }
                      return Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
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
                                    CachedNetworkImage(
                                      imageUrl:
                                          listArticals[index].urlToImage ?? "",
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                            margin: EdgeInsets.all(8),
                                            height: 220,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
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
                                        listArticals[index].title ?? "no title",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
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
                                              listArticals[index].author ?? "",
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey.withValues(
                                                  alpha: 0.8,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            listArticals[index].publishedAt ??
                                                "",
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey.withValues(
                                                alpha: 0.8,
                                              ),
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
                          itemCount: listArticals.length,
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ),
        SizedBox(height: 8),
      ],
    );
  }
}
