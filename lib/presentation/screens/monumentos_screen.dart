import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:web_gestion_app/models/monumento_config_model.dart';
import 'package:web_gestion_app/services/monumentos_config_service.dart';

class MonumentosScreen extends StatefulWidget {
  const MonumentosScreen({super.key});

  @override
  State<MonumentosScreen> createState() => _MonumentosScreenState();
}

class _MonumentosScreenState extends State<MonumentosScreen> {
  final service = MonumentosConfigService();

  List<MonumentoConfig>? monumentos;
  @override
  void initState() {
    super.initState();
    print('Hola');
    cargarDatos();
  }

  void cargarDatos() async {
    final data = await service.getMonumentosConfig();
    setState(() {
      print(data);
      monumentos = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (monumentos == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(
        title: Container(
          margin: EdgeInsets.only(top: 35),
          child: Text(
            "LISTADO DE MONUMENTOS",
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
                    itemCount: monumentos!.length,
                    itemBuilder: (context, index) {
                      return _MonumentCard(monumento: monumentos![index]);
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
                        service.guardarCambiosMonumentos(monumentos!);
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
                SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MonumentCard extends StatefulWidget {
  final MonumentoConfig monumento;
  const _MonumentCard({required this.monumento, super.key});

  @override
  State<_MonumentCard> createState() => _MonumentCardState();
}

class _MonumentCardState extends State<_MonumentCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 2,
        child: Card(
          surfaceTintColor: widget.monumento.activo
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
                    widget.monumento.nombre,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Switch(
                  value: widget.monumento.activo,
                  onChanged: (bool value) {
                    setState(() {
                      widget.monumento.activo = value;
                    });
                  },
                  activeTrackColor: const Color.fromARGB(255, 12, 160, 51),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}