import 'package:app_links/app_links.dart';
import 'package:appgaintask/src/core/api/movie_details_api_client.dart';
import 'package:appgaintask/src/core/app_router.dart';
import 'package:appgaintask/src/core/assets.dart';
import 'package:appgaintask/src/core/log_util.dart';
import 'package:appgaintask/src/model/models/movie_model.dart';
import 'package:appgaintask/src/view_model/network_view_model.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  final _appLinks = AppLinks();
  late AnimationController _controller;
  late NetworkViewModel _viewModel;
  var _isNetworkConnected = false;
  var _navigationStart = false;

  @override
  void initState() {
    super.initState();
    _viewModel = NetworkViewModel();
    _viewModel.registerNetworkStateObserver();
    _isNetworkConnected = _viewModel.getConnected().value;
    _viewModel.getConnected().addListener(networkListener);
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _controller.addListener(() {
      if (_controller.isCompleted) {
        if (_isNetworkConnected) {
          afterAnimationWithNetwork();
        } else {
          afterAnimationWithoutNetwork();
        }
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _viewModel.dispose();
    super.dispose();
  }

  void networkListener() {
    _isNetworkConnected = _viewModel.getConnected().value;
  }

  Future<void> afterAnimationWithNetwork() async {
    final movieId = await getDeepLink();
    if (movieId != null) {
      MovieDetailsApiClient instance = MovieDetailsApiClient.getInstance();
      instance.getMovieDetails().addListener(() {
        final movie = instance.getMovieDetails().value;
        if (!_navigationStart) {
          if (movie != null) {
            Navigator.of(context)
              ..pushReplacementNamed(AppRouter.rMovies)
              ..pushNamed(AppRouter.rMovieDetails, arguments: movie);
          } else {
            navigate(AppRouter.rMovies);
          }
          _navigationStart = true;
        }
      });
      instance.getMovieDetailsById(movieId);
    } else {
      navigate(AppRouter.rMovies);
    }
  }

  Future<void> afterAnimationWithoutNetwork() async {
    final movieId = await getDeepLink();
    navigate(AppRouter.rNoInternetConnection, movieId: movieId);
  }

  void navigate(String routeName, {MovieModel? movie, int? movieId}) =>
      Future.delayed(const Duration(milliseconds: 500)).then(
        (value) => Navigator.pushReplacementNamed(
          context,
          routeName,
          arguments: movie ?? (movieId),
        ),
      );

  Future<int?> getDeepLink() async {
    int? movieId;
    final uri = await _appLinks.getInitialAppLink();
    LogUtil.d("SplashScreen", "Uri: $uri");
    if (uri != null) {
      List<String> parameters = uri.pathSegments;
      if (parameters.length == 2) {
        movieId = int.parse(parameters[1]);
      }
    }
    return movieId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              AppAssets.imgBackground,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: ScaleTransition(
            scale: Tween(begin: 0.0, end: 4.0).animate(
              CurvedAnimation(
                parent: _controller,
                curve: Curves.bounceOut,
              ),
            ),
            child: const Text(
              "Movies App",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
