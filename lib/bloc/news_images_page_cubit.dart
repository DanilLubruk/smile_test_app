import 'package:flutter_bloc/flutter_bloc.dart';

class NewsImagesPageCubit extends Cubit<int> {
  NewsImagesPageCubit() : super(0);

  setPageNumber(int page) => emit(page);
}
