import 'package:appgaintask/src/model/models/movie_model.dart';
import 'package:flutter/material.dart';

class MovieDetailsApiClient {
  static MovieDetailsApiClient? _instance;

  late final ValueNotifier<MovieModel?> _mMovieDetails;

  static MovieDetailsApiClient getInstance() {
    _instance ??= MovieDetailsApiClient._();
    return _instance!;
  }

  MovieDetailsApiClient._() {
    _mMovieDetails = ValueNotifier<MovieModel?>(null);
  }

  ValueNotifier<MovieModel?> getMovieDetails() {
    return _mMovieDetails;
  }

  void getMovieDetailsById(int id) {
    if (_retrieveMovieDetailsRunnable != null) {
      _retrieveMovieDetailsRunnable = null;
    }

    _retrieveMovieDetailsRunnable = _RetrieveMovieDetailsRunnable(id);

    // final Future myHandler = AppExecutors
    //     .getInstance()
    //     .networkIO()
    //     .submit(retrieveMovieDetailsRunnable);
    //
    // AppExecutors.getInstance().networkIO().schedule(() -> {
    // myHandler.cancel(true);
    // }, 5000, TimeUnit.MILLISECONDS);
  }

  _RetrieveMovieDetailsRunnable? _retrieveMovieDetailsRunnable;
}

class _RetrieveMovieDetailsRunnable {
  late final int _movieId;
  late bool cancelRequest;

  _RetrieveMovieDetailsRunnable(int id) {
    _movieId = id;
    cancelRequest = false;
  }

  // @Override
  // public void run() {
  //   try {
  //     Response<MovieModel> response = getMovieDetails(this.movieId).execute();
  //     if (cancelRequest) {
  //       return;
  //     }
  //     LogUtil.d("MovieDetails", "Headers: " + response.headers());
  //     if (response.code() == 200) {
  //       LogUtil.d("MovieDetails", "Response Body: " + response.body());
  //       assert response.body() != null;
  //       MovieModel movie = response.body();
  //       mMovieDetails.postValue(movie);
  //     } else {
  //       LogUtil.d("MovieDetails", "Response Error: " + response.errorBody());
  //       assert response.errorBody() != null;
  //       String error = response.errorBody().string();
  //   LogUtil.d("Tag", "Error " + error);
  //   mMovieDetails.postValue(null);
  //   }
  //   } catch (IOException e) {
  //   e.printStackTrace();
  //   mMovieDetails.postValue(null);
  //   }
  //
  //   if (cancelRequest) {
  //   return;
  //   }
  // }
  //
  // private Call<MovieModel> getMovieDetails(int id) {
  //   return Service.getMovieApi().getMovieById(id, Credentials.API_KEY);
  // }
  //
  // private void cancelRequest() {
  //   LogUtil.d("Tag", "Cancelling Search Request");
  //   cancelRequest = true;
  // }
}
