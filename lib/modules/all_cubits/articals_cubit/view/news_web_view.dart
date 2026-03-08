import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/config/page_route_name.dart';
import 'package:news_app/core/themes/color_pallete.dart';
import 'package:news_app/l10n/app_localizations.dart';

import 'package:news_app/modules/all_cubits/app_setting/app_cubit.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsWebView extends StatefulWidget {
  const NewsWebView({super.key, required this.url});

  static String id = PageRouteName.webSceen;

  final String url;

  @override
  State<NewsWebView> createState() => _NewsWebViewState();
}

class _NewsWebViewState extends State<NewsWebView> {
  late WebViewController controller;

  @override
  void initState() {
    controller = WebViewController();

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.url));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var myCubit = context.read<AppCubit>();
    var local = AppLocalizations.of(context)!;
    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: myCubit.isDark
            ? IconThemeData(color: AppColors.whiteColor)
            : IconThemeData(color: AppColors.darkColor),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          local.view_full_articel,
          style: myCubit.isDark
              ? TextStyle(color: AppColors.whiteColor)
              : TextStyle(color: AppColors.darkColor),
        ),
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
