import 'package:go_router/go_router.dart';
import 'views/home_view.dart';
import 'views/about_view.dart';
import 'views/github_view.dart'; 

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const HomeView(),
      ),
      GoRoute(
        path: '/about',
        name: 'about',
        builder: (context, state) => const AboutView(),
      ),
      GoRoute(
        path: '/github',
        name: 'github', 
        builder: (context, state) => const GithubView(),
      ),
    ],
  );
}
