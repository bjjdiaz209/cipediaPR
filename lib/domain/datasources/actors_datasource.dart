import 'package:cinepediab/domain/entities/actor.dart';

abstract class ActorsDatasource {
  Future<List<Actor>> getActorById(String movieId);
}
