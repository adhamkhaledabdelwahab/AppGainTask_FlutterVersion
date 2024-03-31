// ignore_for_file: non_constant_identifier_names

import 'package:appgaintask/src/model/models/movie_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'movie_search_response.g.dart';

@JsonSerializable()
class MovieSearchResponse {
  final int total_count;
  final List<MovieModel> movies;

  MovieSearchResponse({required this.total_count, required this.movies});

  @override
  String toString() {
    return '${"MovieSearchResponse{total_count=$total_count, movies=$movies"}}';
  }

  factory MovieSearchResponse.fromJson(Map<String, dynamic> json) => _$MovieSearchResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MovieSearchResponseToJson(this);
}
