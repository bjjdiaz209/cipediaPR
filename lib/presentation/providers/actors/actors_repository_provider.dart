import 'package:cinepediab/infrastucture/datasources/actor_moviedb_datasource.dart';
import 'package:cinepediab/infrastucture/repositories/actor_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final actorsRepositoryProvider = Provider((ref) {
  return ActorRepositoryImpl(ActorMoviedbDatasource());
});
