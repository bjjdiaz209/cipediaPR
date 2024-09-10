import 'package:cinepediab/presentation/providers/providers.dart';
import 'package:cinepediab/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
  }

  //rederizado del la lista
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final initialLoading = ref.watch(initialLoadingProvider);
    if (initialLoading) return const FullScreenLoader();

    final slideShowMovies = ref.watch(moviesSlideshowProvider);
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);

    final topRatedMovies = ref.watch(topRatedMoviesProvider);
    final upcomingMovies = ref.watch(upcomingMoviesProvider);

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
                  movies: upcomingMovies,
                  title: 'proximamente',
                  subTittle: 'este mes',
                  loadNextPage: () =>
                      ref.read(upcomingMoviesProvider.notifier).loadNextPage()),
              //*ya no estara aqui por ya pertenece al menu inferior
              //MovieHorizontalListview(
              //  movies: popularMovies,
              //title: 'Populares',
              //subTittle: '',
              //loadNextPage: () =>
              //  ref.read(popularMoviesProvider.notifier).loadNextPage()),
              MovieHorizontalListview(
                  movies: topRatedMovies,
                  title: 'Mejor Calificados',
                  subTittle: 'de todos los tiempos',
                  loadNextPage: () =>
                      ref.read(topRatedMoviesProvider.notifier).loadNextPage()),
              const SizedBox(height: 30),
            ],
          );
        }, childCount: 1)),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
