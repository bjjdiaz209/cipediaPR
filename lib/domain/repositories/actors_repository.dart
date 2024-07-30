import 'package:cinepediab/domain/entities/actor.dart';

abstract class ActorsRepository {
  Future<List<Actor>> getActorById(String movieId);
}
