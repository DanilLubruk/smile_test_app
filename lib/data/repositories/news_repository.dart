import 'package:smile_test_app/data/models/news.dart';
import 'package:smile_test_app/data/network/news/news_client.dart';

class NewsRepository {
  final NewsClient _newsClient;

  NewsRepository(this._newsClient);

  Future<List<News>> getNews() async => (await _newsClient.getNews())
      .map((newsDataObject) => News(newsDataObject))
      .toList();
}
