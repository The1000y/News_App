import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/models/categry_data_model.dart';
// import 'package:cached_network_image/cached_network_image.dart';
import 'package:news_app/modules/all_cubits/articals_cubit/view/artical_view.dart';
import 'package:news_app/modules/all_cubits/sources_cubit/sources_cubit.dart';
import 'package:news_app/modules/all_cubits/sources_cubit/view/sources_view.dart';

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
    ]);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var myTheme = Theme.of(context);
    var currentCubit = context.read<SourcesCubit>();

    return Column(
      children: [
        SizedBox(height: 8),
        SourceView(currentCubit: currentCubit, myTheme: myTheme),

        SizedBox(height: 12),

        ArticalView(widget: widget, myTheme: myTheme),

        SizedBox(height: 8),
      ],
    );
  }
}
