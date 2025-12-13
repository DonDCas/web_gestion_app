import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:web_gestion_app/models/config_model.dart';
import 'package:web_gestion_app/services/configuracion_service.dart';

class ConfiguracionScreen extends StatefulWidget {
  const ConfiguracionScreen({super.key});

  @override
  State<ConfiguracionScreen> createState() => _ConfiguracionScreenState();
}

class _ConfiguracionScreenState extends State<ConfiguracionScreen> {
  final service = ConfiguracionService();
  Config? configuracion;

  // Clave del formulario
  final _formKey = GlobalKey<FormState>();
  // Controladores de los campos
  final TextEditingController _autoresController = TextEditingController();
  final TextEditingController _anioController = TextEditingController();

  @override
  void initState() {
    super.initState();
    cargarDatos();
  }

  void cargarDatos() async {
    final data = await service.getConfiguracion();
    setState(() {
      configuracion = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (configuracion == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(
        title: Container(
          margin: const EdgeInsets.only(top: 35),
          child: const Text(
            "CONFIGURACIÓN",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.only(top: 30),
          child: SizedBox(
            width: MediaQuery.of(context).size.width / 1.5,
            child: Column(
              children: [
                // Aquí añadimos el formulario
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _autoresController,
                        decoration: InputDecoration(
                          labelText: "Introduce los nuevos autores (actual: ${configuracion!.autores})",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Introduce un nombre";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        controller: _anioController,
                        decoration: InputDecoration(
                          labelText: "Introduce el nuevo año (actual: ${configuracion!.anio})",
                          border: const OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Introduce una descripción";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                // Botones
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        context.go('/');
                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.resolveWith((estado) {
                          if (estado.contains(WidgetState.pressed)) {
                            return const Color.fromARGB(255, 197, 197, 197);
                          }
                          return const Color.fromARGB(255, 103, 103, 103);
                        }),
                        minimumSize: const WidgetStatePropertyAll(Size(250, 80)),
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.arrow_back, color: Colors.white, size: 26),
                          SizedBox(width: 10),
                          Text(
                            'Volver al menú',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Aquí puedes usar los datos del formulario
                          configuracion!.autores = _autoresController.text;
                          configuracion!.anio = int.parse(_anioController.text);

                          service.guardarCambiosConfiguracion(configuracion!);
                          context.go('/');
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.resolveWith((estado) {
                          if (estado.contains(WidgetState.pressed)) {
                            return const Color.fromARGB(255, 0, 255, 170);
                          }
                          return const Color.fromARGB(255, 115, 229, 143);
                        }),
                        minimumSize: const WidgetStatePropertyAll(Size(250, 80)),
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.save, color: Colors.white, size: 26),
                          SizedBox(width: 10),
                          Text(
                            'Guardar Cambios',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}