import 'package:cinepediab/presentation/views/views.dart';
import 'package:cinepediab/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const name = 'home-screen';
  final int pageIndex;

  const HomeScreen({super.key, required this.pageIndex});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

//* este mixin es necesario para mantener el estado en el PageView
class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  late PageController pageController;

  @override
  void initState() {
    pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  final viewRoutes = const <Widget>[HomeView(), PopularView(), FavoritesView()];

  @override
  Widget build(BuildContext context) {
    super.build(context);

    if (pageController.hasClients) {
      pageController.animateToPage(
        widget.pageIndex,
        curve: Curves.easeInOut,
        duration: const Duration(milliseconds: 250),
      );
    }

    return Scaffold(
      body: PageView(
        //* esto evitara que rebote
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        //index: widget.pageIndex,
        children: viewRoutes,
      ),
      bottomNavigationBar:
          CustomBottomNavigation(currentIndex: widget.pageIndex),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
