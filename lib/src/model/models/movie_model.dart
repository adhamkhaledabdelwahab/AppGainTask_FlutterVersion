// ignore_for_file: non_constant_identifier_names
import 'package:json_annotation/json_annotation.dart';

part 'movie_model.g.dart';

@JsonSerializable()
class MovieModel {
  final String title;
  final String poster_path;
  final String backdrop_path;
  final String release_date;
  final int id;
  final double vote_average;
  final String overview;
  final String original_language;

  MovieModel({
    required this.title,
    required this.poster_path,
    required this.backdrop_path,
    required this.release_date,
    required this.id,
    required this.vote_average,
    required this.overview,
    required this.original_language,
  });

  @override
  String toString() {
    return "MovieModel{title='$title\\, poster_path='$poster_path\\', backdrop_path='$backdrop_path\\', release_date='$release_date\\', movie_id=$id, vote_average=$vote_average, overview='$overview\\', original_language='$original_language\\'}";
  }

  factory MovieModel.fromJson(Map<String, dynamic> json) => _$MovieModelFromJson(json);

  Map<String, dynamic> toJson() => _$MovieModelToJson(this);
}
