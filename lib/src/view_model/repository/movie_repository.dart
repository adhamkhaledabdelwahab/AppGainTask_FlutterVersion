import 'package:flutter/material.dart';

class MovieRepository{
   static MovieRepository? instance;

   final PopularMoviesApiClient popularMoviesApiClient;

   int mPageNumber;

   static MovieRepository getInstance(){
    instance ??= MovieRepository();
    return instance!;
  }

   MovieRepository(){
    popularMoviesApiClient = PopularMoviesApiClient.getInstance();
  }

   ValueNotifier<List<MovieModel>> getPopularMovies(){
    return popularMoviesApiClient.getMoviesPop();
  }

   void searchPopularMoviesApi(int pageNumber){
    mPageNumber = pageNumber;
    popularMoviesApiClient.searchPopularMoviesApi(pageNumber);
  }

   void searchNextPagePopular(){
    searchPopularMoviesApi(mPageNumber+1);
  }
}