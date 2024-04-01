// ignore_for_file: non_constant_identifier_names

import 'package:appgaintask/src/model/models/movie_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';

part 'movie_search_response.g.dart';

@JsonSerializable()
class MovieSearchResponse {
  final int page;

  final List<MovieModel> results;

  MovieSearchResponse({required this.page, required this.results});

  @override
  String toString() {
    return '${"MovieSearchResponse{total_count=$page, movies=$results"}}';
  }

  factory MovieSearchResponse.fromJson(Map<String, dynamic> json) =>
      _$MovieSearchResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MovieSearchResponseToJson(this);
}
