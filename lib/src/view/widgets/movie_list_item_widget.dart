import 'package:appgaintask/src/core/app_router.dart';
import 'package:appgaintask/src/model/models/movie_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MovieListItemWidget extends StatelessWidget {
  const MovieListItemWidget({super.key, required this.movie});

  final MovieModel movie;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        elevation: 5,
        shadowColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(35),
        ),
        child: Container(
          constraints: const BoxConstraints(
            maxHeight: 500,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(35),
          ),
          clipBehavior: Clip.antiAlias,
          width: MediaQuery.sizeOf(context).width * 0.7,
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                AppRouter.rMovieDetails,
                arguments: movie,
              );
            },
            child: Stack(
              children: [
                Positioned.fill(
                  child: CachedNetworkImage(
                    imageUrl:
                        "https://image.tmdb.org/t/p/original${movie.poster_path}",
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black,
                        Colors.transparent,
                      ],
                      stops: [
                        0,
                        0.5,
                      ],
                    ),
                  ),
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        movie.title,
                        style: const TextStyle(
                          fontFamily: "serif",
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: RatingBarIndicator(
                          itemCount: 5,
                          itemSize: 35,
                          rating: movie.vote_average,
                          unratedColor: Colors.grey,
                          itemBuilder: (_, index) => const Icon(
                            Icons.star,
                            color: Colors.yellow,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
