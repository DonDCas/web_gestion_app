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
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        // Otros estilos para tema claro
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        // Otros estilos para tema oscuro
      ),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
    );
  }
}