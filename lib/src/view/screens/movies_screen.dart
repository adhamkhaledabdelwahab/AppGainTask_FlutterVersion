import 'package:appgaintask/src/core/assets.dart';
import 'package:appgaintask/src/model/models/movie_model.dart';
import 'package:appgaintask/src/view/widgets/movie_list_item_widget.dart';
import 'package:appgaintask/src/view_model/movie_Llst_view_model.dart';
import 'package:flutter/material.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({super.key});

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  late final MovieListViewModel _viewModel;
  late final ScrollController _scrollController;

  @override
  void initState() {
    _viewModel = MovieListViewModel();
    _viewModel.searchPopularMoviesApi(1);
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.atEdge &&
          _scrollController.position.pixels > 0) {
        _viewModel.searchNextPagePopular();
      }
    });
    super.initState();
  }

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: kToolbarHeight,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Popular Movies",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 48,
                    color: Colors.white,
                    fontFamily: "serif"),
              ),
            ),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: _viewModel.getPopMovies(),
                builder: (context, movies, child) {
                  return ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, index) => MovieListItemWidget(
                      movie: movies[index],
                    ),
                    itemCount: movies.length,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
