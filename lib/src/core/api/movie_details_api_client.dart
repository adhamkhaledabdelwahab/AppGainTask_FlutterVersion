import 'dart:async';
import 'dart:isolate';

import 'package:appgaintask/src/core/api/credencials.dart';
import 'package:appgaintask/src/core/api/service.dart';
import 'package:appgaintask/src/core/app_executors.dart';
import 'package:appgaintask/src/core/log_util.dart';
import 'package:appgaintask/src/model/models/movie_model.dart';
import 'package:flutter/material.dart';
import 'package:retrofit/retrofit.dart';

late final ValueNotifier<MovieModel?> _mMovieDetails;

class MovieDetailsApiClient {
  static MovieDetailsApiClient? _instance;
  late AppExecutors _appExecutors;

  static MovieDetailsApiClient getInstance() {
    _instance ??= MovieDetailsApiClient._();
    return _instance!;
  }

  MovieDetailsApiClient._() {
    _mMovieDetails = ValueNotifier<MovieModel?>(null);
    _appExecutors = AppExecutors();
  }

  ValueNotifier<MovieModel?> getMovieDetails() {
    return _mMovieDetails;
  }

  void getMovieDetailsById(int id) {
    if (_retrieveMovieDetailsRunnable != null) {
      _retrieveMovieDetailsRunnable = null;
    }

    _retrieveMovieDetailsRunnable = _RetrieveMovieDetailsRunnable(id);

    _appExecutors.execute(() => _retrieveMovieDetailsRunnable?.run());
  }

  _RetrieveMovieDetailsRunnable? _retrieveMovieDetailsRunnable;
}

class _RetrieveMovieDetailsRunnable {
  late final int _movieId;
  late bool _cancelRequest;

  _RetrieveMovieDetailsRunnable(int id) {
    _movieId = id;
    _cancelRequest = false;
  }

  Future<void> run() async {
    try {
      HttpResponse<MovieModel?> response =
          await Isolate.run<HttpResponse<MovieModel?>>(
        () => getMovieDetails(_movieId),
      );
      if (_cancelRequest) {
        return;
      }
      LogUtil.d("MovieDetails", "Headers: ${response.response.headers}");
      if (response.response.statusCode == 200) {
        LogUtil.d("MovieDetails", "Response Body: ${response.data}");
        if (response.data != null) {
          MovieModel movie = response.data!;
          _mMovieDetails.value = movie;
        }
      } else {
        LogUtil.d("MovieDetails", "Response Error: ${response.response}");
        if (response.response.statusMessage != null) {
          String error = response.response.statusMessage!;
          LogUtil.d("Tag", "Error $error");
        }
        _mMovieDetails.value = null;
      }
    } catch (e) {
      debugPrintStack(stackTrace: e as StackTrace);
      _mMovieDetails.value = null;
    }

    if (_cancelRequest) {
      return;
    }
  }

  Future<HttpResponse<MovieModel?>> getMovieDetails(int id) {
    return Service.getMovieApi().getMovieById(id, Credentials.API_KEY);
  }

  void cancelRequest() {
    LogUtil.d("Tag", "Cancelling Search Request");
    _cancelRequest = true;
  }
}
