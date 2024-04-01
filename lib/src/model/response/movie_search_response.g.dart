// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_search_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieSearchResponse _$MovieSearchResponseFromJson(Map<String, dynamic> json) =>
    MovieSearchResponse(
      page: json['page'] as int?,
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => MovieModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MovieSearchResponseToJson(
        MovieSearchResponse instance) =>
    <String, dynamic>{
      'page': instance.page,
      'results': instance.results,
    };
