import 'package:cinemapedia/presentation/providers/movies/movies_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final initialLoadingProvider = Provider<bool>(
  (ref) {
    // final nowPlayingMovie = ref.watch(nowPlayingMoviesProvider).isEmpty;

    // final popularMovies = ref.watch(popularMoviesProvider).isEmpty;

    // final upcomingMovies = ref.watch(upcomingMoviesProvider).isEmpty;

    // final topRatedMovies = ref.watch(topRatedMoviesProvider).isEmpty
    // ;
//cambiamos un poco
    final step1 = ref.watch(nowPlayingMoviesProvider).isEmpty;

    final step2 = ref.watch(popularMoviesProvider).isEmpty;

    final step3 = ref.watch(upcomingMoviesProvider).isEmpty;

    final step4 = ref.watch(topRatedMoviesProvider).isEmpty;

    if (step1 || step2 || step3 || step4) return true;
    return false;
  },
);
