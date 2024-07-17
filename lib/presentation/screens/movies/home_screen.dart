import 'dart:ffi';

import 'package:cinepediab/presentation/providers/providers.dart';
import 'package:cinepediab/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _HomeView(),
      bottomNavigationBar: CustomBottomNavigation(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
  }

  //rederizado del la lista
  @override
  Widget build(BuildContext context) {
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final slideShowMovies = ref.watch(moviesSlideshowProvider);

    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          floating: true,
          //elevation: 1,
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            title: CustomAppbar(),
          ),
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
          return Column(
            children: [
              //const CustomAppbar(),
              MoviesSlideshow(movies: slideShowMovies),
              MovieHorizontalListview(
                  movies: nowPlayingMovies,
                  title: 'En Cines',
                  subTittle: 'Lunes 20',
                  loadNextPage: () => ref
                      .read(nowPlayingMoviesProvider.notifier)
                      .loadNextPage()),
              MovieHorizontalListview(
                  movies: nowPlayingMovies,
                  title: 'proximamente',
                  subTittle: 'este mes',
                  loadNextPage: () => ref
                      .read(nowPlayingMoviesProvider.notifier)
                      .loadNextPage()),
              MovieHorizontalListview(
                  movies: nowPlayingMovies,
                  title: 'Populares',
                  //subTittle: '',
                  loadNextPage: () => ref
                      .read(nowPlayingMoviesProvider.notifier)
                      .loadNextPage()),
              MovieHorizontalListview(
                  movies: nowPlayingMovies,
                  title: 'Mejor Calificados',
                  subTittle: 'de todos los tiempos',
                  loadNextPage: () => ref
                      .read(nowPlayingMoviesProvider.notifier)
                      .loadNextPage()),
              const SizedBox(height: 30),
            ],
          );
        }, childCount: 1)),
      ],
    );
  }
}
