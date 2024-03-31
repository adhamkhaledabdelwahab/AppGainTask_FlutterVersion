import 'package:appgaintask/src/core/api/movie_api.dart';
import 'package:dio/dio.dart';

class Service {
  static final dio = Dio();
  static final MovieApi retrofit = MovieApi(dio);

  static MovieApi getMovieApi() {
    return retrofit;
  }
}
