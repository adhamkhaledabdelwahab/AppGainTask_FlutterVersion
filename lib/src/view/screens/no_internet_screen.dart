import 'dart:io';

import 'package:appgaintask/src/core/api/movie_details_api_client.dart';
import 'package:appgaintask/src/core/app_router.dart';
import 'package:appgaintask/src/core/assets.dart';
import 'package:appgaintask/src/model/models/movie_model.dart';
import 'package:appgaintask/src/view_model/network_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NoInternetScreen extends StatefulWidget {
  const NoInternetScreen({
    super.key,
    this.movie,
    this.movieId,
  });

  final MovieModel? movie;
  final int? movieId;

  @override
  State<NoInternetScreen> createState() => _NoInternetScreenState();
}

class _NoInternetScreenState extends State<NoInternetScreen> {
  bool _navigationStart = false;

  MovieModel? model;
  late NetworkViewModel _viewModel;

  @override
  void initState() {
    _viewModel = NetworkViewModel();
    _viewModel.registerNetworkStateObserver();
    _viewModel.getConnected().addListener(_onNetworkStateChanged);
    if (widget.movie != null) {
      model = widget.movie;
    }
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  void _onNetworkStateChanged() {
    final connected = _viewModel.getConnected().value;
    if (connected) {
      if (!_navigationStart) {
        if (model != null) {
          Navigator.of(context)
            ..pushReplacementNamed(AppRouter.rMovies)
            ..pushNamed(
              AppRouter.rMovieDetails,
              arguments: model,
            );
        } else {
          final movieId = widget.movieId;
          if (movieId == null) {
            navigate(AppRouter.rMovies);
            _navigationStart = true;
          } else {
            MovieDetailsApiClient instance =
                MovieDetailsApiClient.getInstance();
            instance.getMovieDetails().addListener(() {
              final movieModel = instance.getMovieDetails().value;
              if (!_navigationStart) {
                if (movieModel != null) {
                  navigate(AppRouter.rMovieDetails, movieModel);
                } else {
                  Fluttertoast.showToast(
                    msg: "Invalid Movie ID",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                  if (Platform.isAndroid) {
                    SystemNavigator.pop();
                  } else if (Platform.isIOS) {
                    exit(0);
                  }
                }
                _navigationStart = true;
              }
            });
            instance.getMovieDetailsById(movieId);
          }
        }
      }
    }
  }

  void navigate(String routeName, [MovieModel? movie]) =>
      Future.delayed(const Duration(milliseconds: 500)).then(
        (value) => Navigator.pushReplacementNamed(
          context,
          routeName,
          arguments: movie,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              AppAssets.imgBackground,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: const Center(
          child: Text(
            "No Internet Connection, Reconnect to navigate back to home screen",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 48,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
