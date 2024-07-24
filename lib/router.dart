import 'package:go_router/go_router.dart';
import 'package:moviedb_elements/features/main/presentation/pages/main_screen.dart';
import 'package:moviedb_elements/features/movie/presentation/pages/movie_detail_screen.dart';
import 'package:moviedb_elements/features/splash/presentation/pages/splash_screen.dart';

final GoRouter router = GoRouter(routes: [
  GoRoute(
    path: '/app',
    builder: (context, state) => const MainScreen(),
  ),
  GoRoute(
    path: '/',
    builder: (context, state) => const SplashScreen(),
  ),
  GoRoute(
    path: '/movie/:id',
    builder: (context, state) => MovieDetailScreen(id: int.parse(state.pathParameters['id']!)),
  ),
]);