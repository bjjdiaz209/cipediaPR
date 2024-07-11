import 'package:cinepediab/infrastucture/datasources/moviedb_datasource.dart';
import 'package:cinepediab/infrastucture/repositories/movie_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//este repository es inmutable
final movieRepositoryProvider = Provider((ref) {
  return MovieRepositoryImpl(MoviedbDatasource());
});
