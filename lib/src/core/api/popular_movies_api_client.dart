import 'dart:async';
import 'dart:isolate';

import 'package:appgaintask/src/core/api/credencials.dart';
import 'package:appgaintask/src/core/api/service.dart';
import 'package:appgaintask/src/core/log_util.dart';
import 'package:appgaintask/src/model/models/movie_model.dart';
import 'package:appgaintask/src/model/response/movie_search_response.dart';
import 'package:easy_debounce/easy_throttle.dart';
import 'package:flutter/material.dart';
import 'package:retrofit/retrofit.dart';

late final ValueNotifier<List<MovieModel>> _mMoviesPop;

class PopularMoviesApiClient {
  static PopularMoviesApiClient? _instance;

  static PopularMoviesApiClient getInstance() {
    _instance ??= PopularMoviesApiClient._();
    return _instance!;
  }

  PopularMoviesApiClient._() {
    _mMoviesPop = ValueNotifier<List<MovieModel>>([]);
  }

  ValueNotifier<List<MovieModel>> getMovieDetails() {
    return _mMoviesPop;
  }

  void searchPopularMoviesApi(int pageNumber) {
    if (_retrievePopularMoviesRunnable != null) {
      _retrievePopularMoviesRunnable = null;
    }

    _retrievePopularMoviesRunnable = _RetrievePopularMoviesRunnable(pageNumber);
    EasyThrottle.throttle(
      'PopularMovies',
      const Duration(milliseconds: 5000),
      () => _retrievePopularMoviesRunnable?.run(),
    );
  }

  _RetrievePopularMoviesRunnable? _retrievePopularMoviesRunnable;
}

class _RetrievePopularMoviesRunnable {
  late final int _pageNumber;
  late bool _cancelRequest;

  _RetrievePopularMoviesRunnable(int pageNumber) {
    _pageNumber = pageNumber;
    _cancelRequest = false;
  }

  Future<void> run() async {
    try {
      HttpResponse<MovieSearchResponse?> response =
          await Isolate.run<HttpResponse<MovieSearchResponse?>>(
        () => getPopularMovies(_pageNumber),
      );
      if (_cancelRequest) {
        return;
      }
      LogUtil.d("PopularMovies", "Headers: ${response.response.headers}");
      if (response.response.statusCode == 200) {
        LogUtil.d("PopularMovies", "Response Body: ${response.response.data}");
        if (response.data?.results != null) {
          List<MovieModel> list = response.data!.results!;
          if (_pageNumber == 1) {
            _mMoviesPop.value = list;
          } else {
            List<MovieModel> currentMovies = _mMoviesPop.value;
            _mMoviesPop.value = List.from(currentMovies)..addAll(list);
          }
        }
      } else {
        LogUtil.d("PopularMovies", "Response Error: ${response.response}");
        if (response.response.statusMessage != null) {
          String error = response.response.statusMessage!;
          LogUtil.d("PopularMovies  ", "Error $error");
        }
        _mMoviesPop.value = [];
      }
    } catch (e) {
      LogUtil.d("PopularMovies", "Error:$e");
      _mMoviesPop.value = [];
    }

    if (_cancelRequest) {
      return;
    }
  }

  Future<HttpResponse<MovieSearchResponse?>> getPopularMovies(int pageNumber) {
    return Service.getMovieApi().getPopularMovies(
      Credentials.API_KEY,
      pageNumber,
    );
  }

  void cancelRequest() {
    LogUtil.d("Tag", "Cancelling Search Request");
    _cancelRequest = true;
  }
}
