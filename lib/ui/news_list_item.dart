import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smile_test_app/bloc/news_item_cubit.dart';
import 'package:smile_test_app/data/models/news.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:smile_test_app/ui/ui_consts.dart';
import 'package:smile_test_app/utils/time_utils.dart';

class NewsListItem extends StatefulWidget {
  const NewsListItem({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NewsListItemState();
}

class _NewsListItemState extends State<NewsListItem> {
  @override
  Widget build(BuildContext context) => BlocConsumer<NewsItemCubit, News>(
      builder: (context, item) => Card(
          elevation: 10,
          child: Padding(
              padding: const EdgeInsets.all(UiConsts.screenPadding),
              child: IntrinsicHeight(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  dataView(context),
                  const SizedBox(
                    width: UiConsts.screenPadding,
                  ),
                  imageView(context),
                ],
              )))),
      listener: (context, item) {});

  Widget dataView(BuildContext context) => BlocConsumer<NewsItemCubit, News>(
      builder: (context, item) => Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                  child: Text(item.title,
                      style: GoogleFonts.lora(
                          fontSize: UiConsts.listItemTitleTextSize,
                          fontWeight: FontWeight.bold),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis)),
              Text(TimeUtils.getLocalStrFromDate(item.dateTime),
                  style: const TextStyle(color: Colors.grey))
            ],
          )),
      listener: (context, item) {});

  Widget imageView(BuildContext context) => BlocConsumer<NewsItemCubit, News>(
      builder: (context, item) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CachedNetworkImage(
                alignment: Alignment.center,
                width: UiConsts.cardImageHeight,
                height: UiConsts.cardImageHeight,
                fit: BoxFit.cover,
                imageUrl: item.previewPath,
                imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.fill))),
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(value: downloadProgress.progress),
                errorWidget: (context, url, error) =>
                    const Icon(Icons.error, size: UiConsts.cardImageHeight),
              )
            ],
          ),
      listener: (context, item) {});
}
