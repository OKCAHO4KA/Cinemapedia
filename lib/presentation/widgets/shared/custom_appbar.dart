import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/delegates/search_movie_delegate.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CustomAppBar extends ConsumerWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final colors = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleMedium;

    return SafeArea(
      // bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
            width: double.infinity,
            child: Row(
              children: [
                Icon(Icons.movie_creation_outlined, color: colors.primary),
                const SizedBox(
                  width: 5,
                ),
                Text('Cinemapedia', style: titleStyle),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      // final movieRepository = ref.read(movieRepositoryProvider);
                      final searchedMovie = ref.read(searchedMoviesProvider);
                      final searchQuery = ref.read(searchQueryProvider);

                      showSearch<Movie?>(
                              query: searchQuery,
                              context: context,
                              delegate: SearchMovieDelegate(
                                  initialMovies: searchedMovie,
                                  searchMovies: ref
                                      .read(searchedMoviesProvider.notifier)
                                      .searchMoviesByQuery)
                              //   (query) {
                              //   movieRepository.searchMovie(query);
                              //   ref
                              //       .read(searchQueryProvider.notifier)
                              //       .update((state) => query);
                              //   return movieRepository.searchMovie(query);
                              // })
                              )
                          .then((value) {
                        if (value == null) return;
                        context
                            .push('/home/0/movie/${value.id}'); // value = movie
                      });
                    },
                    icon: const Icon(Icons.search))
              ],
            )),
      ),
    );
  }
}
