import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/repositories/local_storage_repository.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final favoriteMoviesProvider =
    StateNotifierProvider<StorageMoviesNotifier, Map<int, Movie>>((ref) {
  final localStorageRepository = ref.watch(localStorageRepositoryProvider);

  return StorageMoviesNotifier(localStorageRepository: localStorageRepository);
});

/*
123: Movie,
3244: Movie,
645363: Movie

*/

class StorageMoviesNotifier extends StateNotifier<Map<int, Movie>> {
  int page = 0;

  final LocalStorageRepository localStorageRepository;
  StorageMoviesNotifier({required this.localStorageRepository}) : super({});

  Future<void> loadNextPage() async {
    final movies = await localStorageRepository.loadMovies(offset: page * 10);

    page++;

    final temMoviesMap = <int, Movie>{};
    for (final movie in movies) {
      temMoviesMap[movie.id] = movie;
      // state = {...state, movie.id : movie};// esto funcionaria pero si gargamos 20 peli sera 20 actualizaciones del state. no nos gusta
    }
    state = {...state, ...temMoviesMap};
  }
}
