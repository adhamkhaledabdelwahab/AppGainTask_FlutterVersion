import 'package:appgaintask/src/model/models/movie_model.dart';
import 'package:appgaintask/src/view_model/repository/movie_repository.dart';
import 'package:flutter/material.dart';

class MovieListViewModel {
  late final MovieRepository _movieRepository;

  MovieListViewModel() {
    _movieRepository = MovieRepository.getInstance();
  }

  ValueNotifier<List<MovieModel>> getPopMovies() {
    return _movieRepository.getPopularMovies();
  }

  void searchPopularMoviesApi(int pageNumber) {
    _movieRepository.searchPopularMoviesApi(pageNumber);
  }

  void searchNextPagePopular() {
    _movieRepository.searchNextPagePopular();
  }
}
