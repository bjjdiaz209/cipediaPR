import 'package:cinepediab/config/constants/environment.dart';
import 'package:cinepediab/domain/datasources/actors_datasource.dart';
import 'package:cinepediab/domain/entities/actor.dart';
import 'package:cinepediab/infrastucture/mappers/actor_mapper.dart';
import 'package:cinepediab/infrastucture/models/moviedb/credits_response.dart';
import 'package:dio/dio.dart';

class ActorMoviedbDatasource extends ActorsDatasource {
  final dio = Dio(BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environment.theMovieDbkey,
        'language': 'es-MX'
      }));

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async {
    final response = await dio.get('/movie/$movieId/credits');

    final castResponse = CreditsResponse.fromJson(response.data);

    List<Actor> actors = castResponse.cast
        .map((cast) => ActorMapper.castToEntity(cast))
        .toList();

    return actors;
  }
}
