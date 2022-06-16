import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'news_client.g.dart';

@RestApi(baseUrl: "https://education-erp.com/api/")
abstract class NewsClient {
  factory NewsClient(Dio dio, {String baseUrl}) = _NewsClient;

  @GET("ClientApplication/News?schoolType=ballet&cityId=1&count=10")
  Future<List<NewsDataObject>> getNews();
}

@JsonSerializable()
class NewsDataObject {
  String? Id;
  String? Title;
  String? Text;
  String? DateTime;
  String? PreviewPath;
  String? MainImagePath;
  List<String?>? AdditionalImagesPaths;
  String? Language;

  NewsDataObject(
      {this.Id,
      this.Title,
      this.Text,
      this.DateTime,
      this.PreviewPath,
      this.MainImagePath,
      this.AdditionalImagesPaths,
      this.Language});

  factory NewsDataObject.fromJson(Map<String, dynamic> json) =>
      _$NewsDataObjectFromJson(json);
  Map<String, dynamic> toJson() => _$NewsDataObjectToJson(this);
}
