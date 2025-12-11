import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:go_router/go_router.dart';
import 'package:web_gestion_app/models/tema_config_model.dart';
import 'package:web_gestion_app/services/tema_config_service.dart';

class TemaScreen extends StatefulWidget {
  const TemaScreen({super.key});

  @override
  State<TemaScreen> createState() => _TemaScreenState();
}

class _TemaScreenState extends State<TemaScreen> {
  final temaServiceConfig = TemaConfigService();

  TemaConfig? tema;
  Color currentColor = Colors.blue;

  @override
  void initState() {
    super.initState();
    cargarTema();
  }

  void cargarTema() async {
    final data = await temaServiceConfig.getTema();
    setState(() {
      tema = data;
      currentColor = Color(tema!.color);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (tema == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Selector Modo Oscuro
            Container(
              width: MediaQuery.of(context).size.width*0.30+84,
              decoration: BoxDecoration(
                color: Color(tema!.color),
                borderRadius: const BorderRadius.all(Radius.circular(15)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Modo Oscuro'),
                    Switch(
                      value: tema!.modoOscuro,
                      onChanged: (bool value) {
                        setState(() => tema!.modoOscuro = value);
                      },
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            //Selector de color
            Container(
              width: MediaQuery.of(context).size.width*0.30+84,
              decoration: BoxDecoration(
                color: Color(tema!.color),
                borderRadius: BorderRadius.all(Radius.circular(18))
                ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: ColorPicker(
                    pickerColor: currentColor,
                    onColorChanged: (Color color) {
                      setState(() {
                        currentColor = color;
                        tema!.color = currentColor.value;
                      });
                    },
                    pickerAreaBorderRadius: BorderRadius.all(Radius.circular(20)),
                    pickerAreaHeightPercent: 0.5,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            //Selector Tamaño Fuente
            Container(
              decoration: BoxDecoration(
                color: Color(tema!.color),
                borderRadius: BorderRadius.all(Radius.circular(18))

              ),
              width: MediaQuery.of(context).size.width*0.30+84,
              child: Column(
                children: [
                  const Text(
                    'Tamaño de letra',
                    style: TextStyle(fontSize: 18),
                  ),
                  Slider(
                    value: tema!.fontSize.toDouble(),
                    min: 10,
                    max: 40,
                    divisions: 30, // opcional: hace que salte de 1 en 1
                    label: '${tema!.fontSize}px',
                    onChanged: (double value) {
                      setState(() {
                        tema!.fontSize = value.toInt();
                      });
                    },
                  ),
                ],
              ),
            ),

            SizedBox(height: 300,),


            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Boton de volver al menu
                ElevatedButton(
                  onPressed: () {
                    context.go('/');
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.resolveWith((
                      estado,
                    ) {
                      if (estado.contains(WidgetState.pressed)) {
                        return const Color.fromARGB(255, 197, 197, 197);
                      }
                      return const Color.fromARGB(255, 103, 103, 103);
                    }),
                    minimumSize: WidgetStatePropertyAll(Size(250, 80)),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.arrow_back, color: Colors.white, size: 26,),
                      SizedBox(width: 10),
                      Text(
                        'Volver al menú',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 20),
                // Boton de guardar cambios
                ElevatedButton(
                  onPressed: () {
                    temaServiceConfig.guardarTema(tema!);
                    context.go('/');
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.resolveWith((
                      estado,
                    ) {
                      if (estado.contains(WidgetState.pressed)) {
                        return const Color.fromARGB(255, 0, 255, 170);
                      }
                      return const Color.fromARGB(255, 115, 229, 143);
                    }),
                    minimumSize: WidgetStatePropertyAll(Size(250, 80)),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.save, color: Colors.white, size: 26,),
                      SizedBox(width: 10),
                      Text(
                        'Guardar Cambios',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
      
    );
  }
}
