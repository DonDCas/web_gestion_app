import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Editando Conoce Tu Historia'), centerTitle: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                pintaBoton(
                  titulo: "MONUMENTOS",
                  ruta: "/monumentos",
                  color: Colors.blue,
                  icono: Icons.castle_outlined,
                  context: context,
                ),
                SizedBox(width: 200),
                pintaBoton(
                  titulo: "RUTAS APP",
                  ruta: "/rutasapp",
                  color: Colors.green,
                  icono: Icons.signpost_sharp,
                  context: context,
                ),
              ],
            ),
            SizedBox(height: 200),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                pintaBoton(
                  titulo: "CONFIGURACIÓN",
                  ruta: "/config",
                  color: Colors.grey,
                  icono: Icons.settings,
                  context: context,
                ),
                SizedBox(width: 200),
                pintaBoton(
                  titulo: "TEMA",
                  ruta: "/tema",
                  color: Colors.purple,
                  icono: Icons.palette,
                  context: context,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  pintaBoton({
    required String titulo,
    required String ruta,
    required BuildContext context,
    required MaterialColor color,
    required IconData icono,
  }) {
    return ElevatedButton(
      onPressed: () {
        context.go(ruta);
      },
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith((estado) {
          if (estado.contains(WidgetState.pressed)) {
            return color[300];
          }
          return color;
        }),
        minimumSize: WidgetStatePropertyAll(Size(400, 200)),
        elevation: WidgetStateProperty.resolveWith((estado) {
          if (estado.contains(WidgetState.pressed)) return 2;
          return 10;
        }),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icono, size: 56, color: Colors.white),
          SizedBox(width: 15),
          Text(
            titulo,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
