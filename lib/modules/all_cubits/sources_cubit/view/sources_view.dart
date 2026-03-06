import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/themes/color_pallete.dart';
import 'package:news_app/modules/all_cubits/sources_cubit/sources_cubit.dart';
import 'package:news_app/modules/all_cubits/sources_cubit/sources_state.dart';

class SourceView extends StatelessWidget {
  const SourceView({
    super.key,
    required this.currentCubit,
    required this.myTheme,
  });

  final SourcesCubit currentCubit;
  final ThemeData myTheme;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SourcesCubit, SourcesState>(
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
                dividerColor: const Color.fromARGB(0, 57, 31, 31),
                physics: BouncingScrollPhysics(),
                onTap: (index) {
                  currentCubit.onTap(index);
                },

                // labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                isScrollable: true,
                tabs: List.generate(currentCubit.listSources.length, (index) {
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
    );
  }
}
