import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/core/themes/color_pallete.dart';
import 'package:news_app/models/data/article.articals.model.dart';

class ArticalWidget extends StatelessWidget {
  const ArticalWidget({
    super.key,
    required this.listArtical,
    required this.myTheme,
    required this.index,
  });

  final List<Artical>? listArtical;
  final int index;
  final ThemeData myTheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.darkColor, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
            imageUrl: listArtical![index].urlToImage ?? "",
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
              listArtical![index].title ?? "no title",
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
                    listArtical![index].author ?? "",
                    style: myTheme.textTheme.bodySmall,
                  ),
                ),
                Text(
                  listArtical![index].publishedAt ?? "",
                  style: myTheme.textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
