import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritesView extends ConsumerStatefulWidget {
  const FavoritesView({super.key});

  @override
  ConsumerState<FavoritesView> createState() => FavoritesViewState();
}

class FavoritesViewState extends ConsumerState<FavoritesView> {
  @override
  void initState() {
    super.initState();
//llamamos nuestro provider
    ref.read(favoriteMoviesProvider.notifier).loadNextPage();

    // если    ref.read(favoriteMoviesProvider).loadNextPage(); так напишем то нет доступа к notifier у провайдера что ниже класс
  }

  @override
  Widget build(BuildContext context) {
    final favoriteMovies = ref.watch(favoriteMoviesProvider).values.toList();
    return favoriteMovies.isNotEmpty
        ? Scaffold(
            body: ListView.builder(
              itemCount: favoriteMovies.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(favoriteMovies[index].title),
                );
              },
            ),
          )
        : const CircularProgressIndicator();
  }
}
