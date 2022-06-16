import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smile_test_app/data/models/news.dart';

class NewsListBloc extends Bloc<NewsListEvent, NewsListState> {
  static const int _pageSize = 10;

  NewsListBloc() : super(NewsListState([])) {
    on<NextPagePressed>(_handleNextPagePressed);
  }

  _handleNextPagePressed(NextPagePressed event, Emitter emit) {
    var news = event.news;
    var pageNumber = event.pageNumber;

    bool isAllDataRead = pageNumber * _pageSize > news.length - 1;
    var pagedNews = news.sublist(
        isAllDataRead ? news.length - 1 : event.pageNumber * _pageSize);

    emit(isAllDataRead
        ? NewsListDataRead(pagedNews)
        : NewsListDataRead(pagedNews));
  }
}

abstract class NewsListEvent {}

class NextPagePressed extends NewsListEvent {
  final List<News> news;
  final int pageNumber;

  NextPagePressed(this.news, this.pageNumber);
}

class NewsListState {
  final List<News> pagedViews;

  NewsListState(this.pagedViews);
}

class NewsListUpdated extends NewsListState {
  NewsListUpdated(List<News> pagedViews) : super(pagedViews);
}

class NewsListDataRead extends NewsListState {
  NewsListDataRead(List<News> pagedViews) : super(pagedViews);
}
