import 'package:go_router/go_router.dart';
import 'package:web_gestion_app/presentation/screens/home_screen.dart';
import 'package:web_gestion_app/presentation/screens/monumentos_screen.dart';
import 'package:web_gestion_app/presentation/screens/tema_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/monumentos',
      builder: (context, state) => const MonumentosScreen(),
    ),
    GoRoute(
      path: '/rutasapp',
      builder: (context, state) => const MonumentosScreen(),
    ),
    GoRoute(
      path: '/tema',
      builder: (context, state) => const TemaScreen(),
    ),
    GoRoute(
      path: '/config',
      builder: (context, state) => const MonumentosScreen(),
    ),
  ]
);