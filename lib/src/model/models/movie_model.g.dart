// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieModel _$MovieModelFromJson(Map<String, dynamic> json) => MovieModel(
      title: json['title'] as String?,
      poster_path: json['poster_path'] as String?,
      backdrop_path: json['backdrop_path'] as String?,
      release_date: json['release_date'] as String?,
      id: json['id'] as int?,
      vote_average: (json['vote_average'] as num?)?.toDouble(),
      overview: json['overview'] as String?,
      original_language: json['original_language'] as String?,
    );

Map<String, dynamic> _$MovieModelToJson(MovieModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'poster_path': instance.poster_path,
      'backdrop_path': instance.backdrop_path,
      'release_date': instance.release_date,
      'id': instance.id,
      'vote_average': instance.vote_average,
      'overview': instance.overview,
      'original_language': instance.original_language,
    };
