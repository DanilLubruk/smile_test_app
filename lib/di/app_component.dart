import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:smile_test_app/data/network/news/news_client.dart';
import 'package:smile_test_app/data/repositories/news_repository.dart';

abstract class AppComponent {
  static Future create() async {
    GetIt.I.registerSingleton<Dio>(Dio());
    GetIt.I.registerFactory<NewsClient>(() => NewsClient(_getDio()));
    GetIt.I.registerFactory<NewsRepository>(
        () => NewsRepository(_getNewsClient()));
  }

  static Dio _getDio() => GetIt.I.get<Dio>();

  static NewsClient _getNewsClient() => GetIt.I.get<NewsClient>();

  static NewsRepository getNewsRepository() => GetIt.I.get<NewsRepository>();
}
