import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smile_test_app/data/models/news.dart';
import 'package:smile_test_app/di/app_component.dart';

class NewsListCubit extends Cubit<DataState> {
  NewsListCubit() : super(DataNotLoaded([]));

  Future loadData() async =>
      emit(DataLoaded(await AppComponent.getNewsRepository().getNews()));
}

class DataState {
  final List<News> news;
  DataState(this.news);
}

class DataLoaded extends DataState {
  DataLoaded(super.news);
}

class DataNotLoaded extends DataState {
  DataNotLoaded(super.news);
}
