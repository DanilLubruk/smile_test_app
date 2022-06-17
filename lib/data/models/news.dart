import 'dart:core';

import 'package:smile_test_app/data/network/network_consts.dart';
import 'package:smile_test_app/data/network/news/news_client.dart';

class News {
  final int id;
  final String title;
  final String text;
  final String _dateTime;
  final String previewPath;
  final String mainImagePath;
  final List<String> additionalImagesPaths;
  final String language;

  News(NewsDataObject newsDataObject)
      : id = newsDataObject.Id ?? NetworkConsts.undefinedIdValue,
        title = newsDataObject.Title ?? "",
        text = newsDataObject.Text ?? "",
        _dateTime = newsDataObject.DateTime ?? "",
        previewPath = newsDataObject.PreviewPath ?? "",
        mainImagePath = newsDataObject.MainImagePath ?? "",
        additionalImagesPaths =
            newsDataObject.AdditionalImagesPaths?.map((path) => path ?? "")
                    .toList() ??
                [],
        language = newsDataObject.Language ?? "ru";

  DateTime get dateTime => DateTime.tryParse(_dateTime) ?? DateTime.now();

  List<String> get allImages => [mainImagePath, ...additionalImagesPaths];
}
