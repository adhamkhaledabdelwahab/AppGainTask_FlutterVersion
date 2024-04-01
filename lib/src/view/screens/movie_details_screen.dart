import 'package:appgaintask/src/core/app_router.dart';
import 'package:appgaintask/src/model/models/movie_model.dart';
import 'package:appgaintask/src/view_model/network_view_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MovieDetailsScreen extends StatefulWidget {
  const MovieDetailsScreen({super.key, required this.movie});

  final MovieModel movie;

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  var _navigationStart = false;
  late final NetworkViewModel _viewModel;

  @override
  void initState() {
    _viewModel = NetworkViewModel();
    _viewModel.registerNetworkStateObserver();
    _viewModel.getConnected().addListener(() {
      final connected = _viewModel.getConnected().value;
      if (!connected) {
        if (!_navigationStart) {
          Navigator.pushReplacementNamed(
            context,
            AppRouter.rNoInternetConnection,
            arguments: widget.movie,
          );
          _navigationStart = true;
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Positioned.fill(
              child: CachedNetworkImage(
                imageUrl:
                    "https://image.tmdb.org/t/p/original${widget.movie.poster_path}",
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0.0,
              right: 0.0,
              child: Container(
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
                      1,
                    ],
                  ),
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      widget.movie.title ?? "",
                      style: const TextStyle(
                        fontFamily: "serif",
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    RatingBarIndicator(
                      itemCount: 5,
                      itemSize: 40,
                      rating: widget.movie.vote_average != null
                          ? widget.movie.vote_average! / 2
                          : 0,
                      unratedColor: Colors.grey,
                      itemBuilder: (_, index) => Icon(
                        Icons.star,
                        color: Colors.tealAccent.shade700,
                      ),
                    ),
                    Text(
                      widget.movie.overview ?? "",
                      style: const TextStyle(
                        fontFamily: "serif",
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 30,
              left: 10,
              child: IconButton(
                style: IconButton.styleFrom(
                    backgroundColor: Colors.black45,
                    padding: const EdgeInsets.all(12.0)),
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
