// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_client.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsDataObject _$NewsDataObjectFromJson(Map<String, dynamic> json) =>
    NewsDataObject(
      Id: json['Id'] as int?,
      Title: json['Title'] as String?,
      Text: json['Text'] as String?,
      DateTime: json['DateTime'] as String?,
      PreviewPath: json['PreviewPath'] as String?,
      MainImagePath: json['MainImagePath'] as String?,
      AdditionalImagesPaths: (json['AdditionalImagesPaths'] as List<dynamic>?)
          ?.map((e) => e as String?)
          .toList(),
      Language: json['Language'] as String?,
    );

Map<String, dynamic> _$NewsDataObjectToJson(NewsDataObject instance) =>
    <String, dynamic>{
      'Id': instance.Id,
      'Title': instance.Title,
      'Text': instance.Text,
      'DateTime': instance.DateTime,
      'PreviewPath': instance.PreviewPath,
      'MainImagePath': instance.MainImagePath,
      'AdditionalImagesPaths': instance.AdditionalImagesPaths,
      'Language': instance.Language,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _NewsClient implements NewsClient {
  _NewsClient(this._dio, {this.baseUrl}) {
    baseUrl ??= 'https://education-erp.com/api/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<List<NewsDataObject>> getNews() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<List<dynamic>>(
        _setStreamType<List<NewsDataObject>>(Options(
                method: 'GET', headers: _headers, extra: _extra)
            .compose(_dio.options,
                'ClientApplication/News?schoolType=ballet&cityId=1&count=10',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) => NewsDataObject.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
