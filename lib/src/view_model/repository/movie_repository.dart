import 'package:appgaintask/src/core/api/popular_movies_api_client.dart';
import 'package:appgaintask/src/model/models/movie_model.dart';
import 'package:flutter/material.dart';

class MovieRepository{
   static MovieRepository? instance;

   late final PopularMoviesApiClient _popularMoviesApiClient;

   late int mPageNumber;

   static MovieRepository getInstance(){
    instance ??= MovieRepository._();
    return instance!;
  }

   MovieRepository._(){
     _popularMoviesApiClient = PopularMoviesApiClient.getInstance();
  }

   ValueNotifier<List<MovieModel>> getPopularMovies(){
    return _popularMoviesApiClient.getMovieDetails();
  }

   void searchPopularMoviesApi(int pageNumber){
    mPageNumber = pageNumber;
    _popularMoviesApiClient.searchPopularMoviesApi(pageNumber);
  }

   void searchNextPagePopular(){
    searchPopularMoviesApi(mPageNumber+1);
  }
}