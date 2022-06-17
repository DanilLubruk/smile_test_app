import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:smile_test_app/assets/strings.dart';
import 'package:smile_test_app/bloc/news_images_page_cubit.dart';
import 'package:smile_test_app/ui/components/shimmering_placeholder.dart';
import 'package:smile_test_app/ui/ui_consts.dart';
import 'package:photo_view/photo_view.dart';

import '../../../bloc/news_item_cubit.dart';
import '../../../data/models/news.dart';

class NewsViewScreen extends StatefulWidget {
  final News news;

  const NewsViewScreen({required this.news, Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NewsViewScreenState();
}

class _NewsViewScreenState extends State<NewsViewScreen> {
  final PageController pageController = PageController();
  final NewsImagesPageCubit newsImagesPageCubit = NewsImagesPageCubit();

  @override
  Widget build(BuildContext context) => BlocProvider<NewsImagesPageCubit>(
      create: (context) => newsImagesPageCubit,
      child: BlocConsumer<NewsImagesPageCubit, int>(
          listener: (context, pageNumber) {},
          builder: (context, pageNumber) => WillPopScope(
              onWillPop: () async => true,
              child: Scaffold(
                  appBar: AppBar(
                    title: Text(Strings.newsCaption,
                        style: UiConsts.headerTextStyle),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    centerTitle: true,
                  ),
                  backgroundColor: Theme.of(context).backgroundColor,
                  body: Padding(
                      padding: const EdgeInsets.all(UiConsts.screenPadding),
                      child: SingleChildScrollView(
                          child: Column(children: [
                        SizedBox(
                            child: Text(
                          widget.news.title,
                          style: GoogleFonts.lora(
                              fontSize: UiConsts.headerTextSize,
                              fontWeight: FontWeight.bold),
                        )),
                        const SizedBox(
                          height: UiConsts.screenPadding,
                        ),
                        additionalItemsGallery(context),
                        const SizedBox(
                          height: UiConsts.screenPadding,
                        ),
                        Visibility(
                            visible: widget.news.allImages.length > 1,
                            child: Text(Strings.getPagesCaption(
                                pageNumber + 1, widget.news.allImages.length))),
                        const SizedBox(
                          height: UiConsts.screenPadding,
                        ),
                        const Divider(
                          thickness: 1,
                          color: Colors.black,
                        ),
                        const SizedBox(
                          height: UiConsts.screenPadding,
                        ),
                        Html(data: widget.news.text),
                      ])))))));

  Widget additionalItemsGallery(BuildContext context) => Container(
      height: UiConsts.galleryHeight,
      child: PhotoViewGallery.builder(
        scrollPhysics: const BouncingScrollPhysics(),
        builder: (BuildContext context, int index) {
          return PhotoViewGalleryPageOptions(
            imageProvider:
                CachedNetworkImageProvider(widget.news.allImages[index]),
            initialScale: PhotoViewComputedScale.contained,
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 1.8,
            heroAttributes: PhotoViewHeroAttributes(tag: index),
          );
        },
        itemCount: widget.news.allImages.length,
        pageController: pageController,
        backgroundDecoration: const BoxDecoration(color: Colors.white),
        onPageChanged: (page) => newsImagesPageCubit.setPageNumber(page),
      ));

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }
}
