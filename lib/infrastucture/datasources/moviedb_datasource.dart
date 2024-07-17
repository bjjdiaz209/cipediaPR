import 'package:cinepediab/config/constants/environment.dart';
import 'package:cinepediab/domain/datasources/movies_datasource.dart';
import 'package:cinepediab/domain/entities/movie.dart';
import 'package:cinepediab/infrastucture/mappers/movie_mapper.dart';
import 'package:cinepediab/infrastucture/models/moviedb/moviedb_response.dart';
import 'package:dio/dio.dart';

class MoviedbDatasource extends MoviesDatasource {
  final dio = Dio(BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environment.theMovieDbkey,
        'language': 'es-MX'
      }));

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response =
        await dio.get('/movie/now_playing', queryParameters: {'page': page});
    final movieDBResponse = MovieDbReponse.fromJson(response.data);

    final List<Movie> movies = movieDBResponse.results
        .where((moviedb) => moviedb.posterPath != 'no-poster')
        .map((moviedb) => MovieMapper.movieDBToEntity(moviedb))
        .toList();
    return movies;
  }
}
