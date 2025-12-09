import 'package:flutter/material.dart';
import 'Routes/app_routes.dart';
import 'package:web_gestion_app/presentation/screens/Home_Screen.dart';


void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
    );
  }
}