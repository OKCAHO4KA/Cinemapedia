import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movie_info_provider.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovieScreen extends ConsumerStatefulWidget {
  static const String name = 'movie-screen';
  final String movieId;
  const MovieScreen({super.key, required this.movieId});

  @override
  MovieScreenState createState() => MovieScreenState();
}

class MovieScreenState extends ConsumerState<MovieScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(movieInfoProvider.notifier).loadMovie(widget.movieId);
    ref.read(actorsByMovieProvider.notifier).loadActors(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    // final movies = ref.watch(movieInfoProvider);
    // final movie = movies[widget.movieId]; en una linia :
    final Movie? movie = ref.watch(movieInfoProvider)[widget.movieId];

    if (movie == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
        body: CustomScrollView(
      physics: const ClampingScrollPhysics(),
      slivers: [
        _CustomSliverAppBar(
          movie: movie,
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
          return _MovieDetails(movie: movie);
        }, childCount: 1))
      ],
    ));
  }
}

class _MovieDetails extends StatelessWidget {
  final Movie movie;
  const _MovieDetails({required this.movie});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    // final colors = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image.network(
                    movie.posterPath,
                    width: size.width * 0.30,
                  )),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                width: (size.width - 40) * 0.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(movie.title, style: textStyle.titleLarge),
                    Text(movie.overview)
                  ],
                ),
              )
            ],
          ),
        ),
//Generos de la pelicula
        Padding(
            padding: const EdgeInsets.all(8),
            child: Wrap(children: [
              ...movie.genreIds.map((e) => Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: Chip(
                    label: Text(e),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  )))
            ])),
        _ActorsByMovie(
          movieId: movie.id.toString(),
        ),
        const SizedBox(
          height: 50,
        )
      ],
    );
  }
}

class _ActorsByMovie extends ConsumerWidget {
  final String movieId;
  const _ActorsByMovie({required this.movieId});

  @override
  Widget build(BuildContext context, ref) {
    final actorsByMovie = ref.watch(actorsByMovieProvider);

    if (actorsByMovie[movieId] == null) {
      return const CircularProgressIndicator();
    }
    final actors = actorsByMovie[movieId];
    return SizedBox(
      height: 300,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: actors!.length,
          itemBuilder: (context, index) {
            final actor = actors[index];
            return Container(
              width: 135,
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //ActorFoto
                  FadeInRight(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image.network(
                        actor.profilePath,
                        height: 180,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 135,
                    height: 3,
                  ),
                  Text(
                    actor.name,
                    maxLines: 2,
                  ),
                  Text(
                    actor.character ?? '',
                    maxLines: 2,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }),
    );
  }
}

class _CustomSliverAppBar extends StatelessWidget {
  final Movie movie;

  const _CustomSliverAppBar({required this.movie});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return SliverAppBar(
      actions: [
        IconButton(
            onPressed: () {},
            icon: const

                //  Icon(Icons.favorite_border))
                Icon(
              Icons.favorite_rounded,
              color: Colors.red,
            ))
      ],
      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.7,
      foregroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        // title: Text(
        //   movie.title,
        //   style: const TextStyle(fontSize: 20),
        //   textAlign: TextAlign.start,
        // ),
        titlePadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        background: Stack(
          children: [
            SizedBox.expand(
                child: Image.network(movie.posterPath, fit: BoxFit.cover,
                    loadingBuilder: ((context, child, loadingProgress) {
              if (loadingProgress != null) return const SizedBox();

              return FadeIn(child: child);
            }))),
            const _CustomGradient(
                color1: Colors.transparent,
                color2: Colors.black87,
                stops: [0.8, 1.0],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),
            const _CustomGradient(
                color1: Colors.black87,
                color2: Colors.transparent,
                stops: [0.0, 0.4],
                begin: Alignment.topLeft,
                end: Alignment.bottomCenter),
            const _CustomGradient(
                color1: Colors.black87,
                color2: Colors.transparent,
                stops: [0.0, 0.4],
                begin: Alignment.topRight,
                end: Alignment.bottomCenter),
          ],
        ),
      ),
    );
  }
}

class _CustomGradient extends StatelessWidget {
  final Color color1;
  final Color color2;
  final List<double>? stops;
  final AlignmentGeometry? begin;
  final AlignmentGeometry? end;

  const _CustomGradient(
      {required this.color1,
      required this.color2,
      this.stops,
      this.begin = Alignment.topCenter,
      this.end = Alignment.bottomCenter});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [color1, color2], stops: stops, begin: begin!, end: end!),
        ),
      ),
    );
  }
}
