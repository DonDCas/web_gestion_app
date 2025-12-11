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
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Selector Modo Oscuro
              Container(
                width: MediaQuery.of(context).size.width / 2,
                decoration: BoxDecoration(
                  color: tema == null || tema!.modoOscuro
                      ? const Color.fromARGB(255, 234, 184, 246)
                      : const Color.fromARGB(139, 213, 213, 213),
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: const Text(
                          'Modo Oscuro',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Switch(
                        value: tema!.modoOscuro,
                        onChanged: (bool value) {
                          setState(() => tema!.modoOscuro = value);
                        },
                        activeTrackColor: const Color.fromARGB(255, 166, 38, 235),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              //Selector de color
              Container(
                width: MediaQuery.of(context).size.width / 2,
                decoration: BoxDecoration(
                  color: Color(tema!.color),
                  borderRadius: BorderRadius.all(Radius.circular(18)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 160,
                    vertical: 20,
                  ),
                  child: ColorPicker(
                    pickerColor: currentColor,
                    onColorChanged: (Color color) {
                      setState(() {
                        currentColor = color;
                        tema!.color = currentColor.toARGB32();
                      });
                    },
                    pickerAreaBorderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    pickerAreaHeightPercent: 0.5,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              //Selector Tamaño Fuente
              Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 234, 184, 246),
                  borderRadius: BorderRadius.all(Radius.circular(18)),
                ),
                width: MediaQuery.of(context).size.width / 2,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: const Text(
                        'Tamaño de letra',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Slider(
                      thumbColor: const Color.fromARGB(255, 166, 38, 235),
                      activeColor: const Color.fromARGB(255, 166, 38, 235),
                      value: tema!.fontSize.toDouble(),
                      min: 10,
                      max: 30,
                      divisions: 10, // opcional: hace que salte de 1 en 1
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

              SizedBox(height: 300),

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
                        Icon(Icons.arrow_back, color: Colors.white, size: 26),
                        SizedBox(width: 10),
                        Text(
                          'Volver al menú',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
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
                        Icon(Icons.save, color: Colors.white, size: 26),
                        SizedBox(width: 10),
                        Text(
                          'Guardar Cambios',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
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
      ),
    );
  }
}
