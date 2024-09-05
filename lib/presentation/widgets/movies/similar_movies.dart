import 'package:cinepediab/presentation/providers/movies/movie_repository_provider.dart';
import 'package:cinepediab/presentation/widgets/movies/movie_horizontal_listview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final similarMoviesProvider = FutureProvider.family((ref, int movieId) {
  final movieRepository = ref.watch(movieRepositoryProvider);
  return movieRepository.getSimilarMovies(movieId);
});

class SimilarMovies extends ConsumerWidget {
  final int movieId;
  const SimilarMovies({required this.movieId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final similarMoviesFuture = ref.watch(similarMoviesProvider(movieId));

    return similarMoviesFuture.when(
        data: (movies) => Container(
              margin: const EdgeInsetsDirectional.only(bottom: 50),
              child: MovieHorizontalListview(
                title: 'Recomendaciones',
                movies: movies,
              ),
            ),
        error: (_, __) =>
            const Center(child: Text('No se pudo cargar peliculas similares')),
        loading: () => const Center(
                child: CircularProgressIndicator(
              strokeWidth: 2,
            )));
  }
}
