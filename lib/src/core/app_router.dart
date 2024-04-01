import 'package:appgaintask/src/model/models/movie_model.dart';
import 'package:appgaintask/src/view/screens/movie_details_screen.dart';
import 'package:appgaintask/src/view/screens/movies_screen.dart';
import 'package:appgaintask/src/view/screens/no_internet_screen.dart';
import 'package:appgaintask/src/view/screens/splash_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static const String rSplash = '/';
  static const String rMovies = '/movies';
  static const String rMovieDetails = '/movie-details';
  static const String rNoInternetConnection = '/no-internet-connection';

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case rSplash:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );
      case rMovies:
        return MaterialPageRoute(
          builder: (_) => const MoviesScreen(),
        );
      case rMovieDetails:
        final movie = settings.arguments as MovieModel;
        return MaterialPageRoute(
          builder: (_) => MovieDetailsScreen(
            movie: movie,
          ),
        );
      case rNoInternetConnection:
        int? movieId;
        MovieModel? movie;
        if (settings.arguments is MovieModel) {
          movie = settings.arguments as MovieModel;
        } else if (settings.arguments is int) {
          movieId = settings.arguments as int;
        }
        return MaterialPageRoute(
          builder: (_) => NoInternetScreen(
            movie: movie,
            movieId: movieId,
          ),
        );
      default:
        return null;
    }
  }
}
