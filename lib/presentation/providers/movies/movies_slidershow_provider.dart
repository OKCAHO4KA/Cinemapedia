import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final moviesSliderShowProvider = Provider<List<Movie>>((ref) {
  final nowPlayingMovie = ref.watch(nowPlayingMoviesProvider);
  if (nowPlayingMovie.isEmpty) {
    return [];
  }
  return nowPlayingMovie.sublist(0, 6);
});
