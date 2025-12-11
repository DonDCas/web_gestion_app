import 'package:flutter/material.dart';
import 'package:web_gestion_app/models/tema_config_model.dart';
import 'package:web_gestion_app/services/tema_config_service.dart';
import 'Routes/app_routes.dart';
import 'package:web_gestion_app/presentation/screens/Home_Screen.dart';


void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final temaConfig = TemaConfigService();
  TemaConfig? tema =TemaConfig(color: 0, modoOscuro: false, fontSize: 18);

  @override
  initState(){
      super.initState();
      cargarTema();
  }

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
      themeMode: (tema == null || tema!.modoOscuro) ? ThemeMode.dark : ThemeMode.light,
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
    );
  }
  
  void cargarTema() async {
    final data = await temaConfig.getTema();
    setState(() {
      tema = data;
    });
  }
}