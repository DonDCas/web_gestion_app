import 'package:go_router/go_router.dart';
import 'package:web_gestion_app/presentation/screens/home_screen.dart';
import 'package:web_gestion_app/presentation/screens/monumentos_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/Monumentos',
      builder: (context, state) => const MonumentosScreen(),
    )
  ]
);