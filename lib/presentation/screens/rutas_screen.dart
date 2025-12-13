import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:web_gestion_app/models/ruta_config_model.dart';
import 'package:web_gestion_app/services/rutas_config_service.dart';

class RutasScreen extends StatefulWidget {
  const RutasScreen({super.key});

  @override
  State<RutasScreen> createState() => _RutasAppState();
}

class _RutasAppState extends State<RutasScreen> {
  final service = RutasConfigService();

  List<RutaConfig>? rutas;

  @override
  void initState() {
    super.initState();
    print('Hola');
    cargarDatos();
  }

  void cargarDatos() async {
    final data = await service.getRutasConfig();
    setState(() {
      print(data);
      rutas = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (rutas == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(
        title: Container(
          margin: EdgeInsets.only(top: 35),
          child: Text(
            "RUTAS DE LA APP",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.only(top: 30),
          child: SizedBox(
            width: MediaQuery.of(context).size.width / 1.5,
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: rutas!.length,
                    itemBuilder: (context, index) {
                      return _RutasCard(ruta: rutas![index]);
                    },
                  ),
                ),
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
                        service.guardarCambiosRutas(rutas!);
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
                SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RutasCard extends StatefulWidget {
  final RutaConfig ruta;
  const _RutasCard({required this.ruta, super.key});

  @override
  State<_RutasCard> createState() => _MonumentCardState();
}

class _MonumentCardState extends State<_RutasCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 2,
        child: Card(
          surfaceTintColor: widget.ruta.active
              ? const Color.fromARGB(255, 84, 255, 31)
              : const Color.fromARGB(192, 158, 158, 158),
          elevation: 6,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    widget.ruta.titulo,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Checkbox(
                  value: widget.ruta.active,
                  onChanged: (bool? value) {
                    setState(() {
                      widget.ruta.active = value ?? false;
                    });
                  },
                  activeColor: const Color.fromARGB(255, 12, 160, 51),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
