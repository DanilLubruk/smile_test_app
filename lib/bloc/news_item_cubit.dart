import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smile_test_app/data/models/news.dart';

class NewsItemCubit extends Cubit<News> {
  NewsItemCubit(News item) : super(item);
}
