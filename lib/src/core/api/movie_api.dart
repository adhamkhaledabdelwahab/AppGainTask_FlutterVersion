import 'package:appgaintask/src/core/api/credencials.dart';
import 'package:appgaintask/src/model/models/movie_model.dart';
import 'package:appgaintask/src/model/response/movie_search_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'movie_api.g.dart';

@RestApi(baseUrl: Credentials.BASE_URL)
abstract class MovieApi {
  factory MovieApi(Dio dio, {String baseUrl}) = _MovieApi;

  @GET("3/movie/{movie_id}")
  Future<MovieModel> getMovieById(
    @Path("movie_id") int id,
    @Query("api_key") String key,
  );

  @GET("3/movie/popular")
  Future<MovieSearchResponse> getPopularMovies(
    @Query("api_key") String key,
    @Query("page") int page,
  );
}
