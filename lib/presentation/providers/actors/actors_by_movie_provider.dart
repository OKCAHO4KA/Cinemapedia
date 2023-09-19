import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/presentation/providers/actors/actors_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final actorsByMovieProvider =
    StateNotifierProvider<ActorsByMovieNotifier, Map<String, List<Actor>>>(
        (ref) {
  final actorsRepository = ref.watch(actorsRepositoryProvider);
  return ActorsByMovieNotifier(
      getListActors: actorsRepository.getActorsByMovie);
});
/*

{//String: List<Actor>
  '22': List<Actor>,
  '33':List<Actor>
  '44':List<Actor>

  '505645': Movie(),

} */
typedef GetActorsCallback = Future<List<Actor>> Function(String movieId);

class ActorsByMovieNotifier extends StateNotifier<Map<String, List<Actor>>> {
  final GetActorsCallback getListActors;
  ActorsByMovieNotifier({required this.getListActors}) : super({});
  //inicializamos con map vacio

  Future<void> loadActors(String movieId) async {
    if (state[movieId] != null) return;

    final List<Actor> actores = await getListActors(movieId);

    state = {...state, movieId: actores};
    // ...spret
  }
}
