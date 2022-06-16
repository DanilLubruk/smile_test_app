import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smile_test_app/data/repositories/news_repository.dart';

class PaginatorCubit extends Cubit<int> {
  static const int initPage = 1;

  PaginatorCubit() : super(initPage);

  void nextPage() => emit(state + 1);

}
