import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();

    ref.read(nowPlayingMoviesProvider.notifier).loadNexPage();
    ref.read(popularMoviesProvider.notifier).loadNexPage();
    ref.read(upcomingMoviesProvider.notifier).loadNexPage();
    ref.read(topRatedMoviesProvider.notifier).loadNexPage();
  }

  @override
  Widget build(BuildContext context) {
    final initialLoading = ref.watch(initialLoadingProvider);

    if (initialLoading) return const FullScreenLoader();

    final slideShowMovies = ref.watch(moviesSliderShowProvider);
    final nowPlayingMovie = ref.watch(nowPlayingMoviesProvider);

    final popularMovies = ref.watch(popularMoviesProvider);

    final upcomingMovies = ref.watch(upcomingMoviesProvider);

    final topRatedMovies = ref.watch(topRatedMoviesProvider);

    // if (nowPlayingMovie.isEmpty) {
    //   return const Center(child: CircularProgressIndicator());
    // }
    // return SingleChildScrollView(

    return
        // Visibility(
        // visible: !initialLoading,
        // child:
        CustomScrollView(

            // child: Column(
            slivers: [
          const SliverAppBar(
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              title: CustomAppBar(),
            ),
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // const CustomAppBar(),

                MoviesSlideshow(movies: slideShowMovies),

                MovieHorizontalListView(
                  movies: nowPlayingMovie,
                  title: 'En cines',
                  subTitle: 'Lunes',
                  loadNextPage: () => {
                    ref.watch(nowPlayingMoviesProvider.notifier).loadNexPage()
                  },
                ),
                MovieHorizontalListView(
                  movies: upcomingMovies,
                  title: 'Próximamente',
                  subTitle: 'Este mes',
                  loadNextPage: () => {
                    ref.watch(upcomingMoviesProvider.notifier).loadNexPage()
                  },
                ),
                MovieHorizontalListView(
                  movies: popularMovies,
                  title: 'Populares',
                  // subTitle: 'Lunes',
                  loadNextPage: () =>
                      {ref.watch(popularMoviesProvider.notifier).loadNexPage()},
                ),
                MovieHorizontalListView(
                  movies: topRatedMovies,
                  title: 'Mejor calificadas',
                  subTitle: 'De siempre',
                  loadNextPage: () => {
                    ref.watch(topRatedMoviesProvider.notifier).loadNexPage()
                  },
                ),
                const SizedBox(
                  height: 20,
                )
                // Expanded(
                //   child: ListView.builder(
                //       itemBuilder: (context, index) {
                //         final movie = nowPlayingMovie[index];
                //         return ListTile(
                //           title: Text(movie.title),
                //         );
                //       },
                //       itemCount: nowPlayingMovie.length),
                // ),
              ],
            );
          }, childCount: 1))
        ]
            // ),
            );
  }
}
