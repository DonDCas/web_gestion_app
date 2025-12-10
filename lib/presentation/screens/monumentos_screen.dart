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
      appBar: AppBar(title: const Text("Monumentos")),
      body: Column(
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: (){
                  context.go('/');
                },
                child: Container(
                  height: 30,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.arrow_back),
                      Text('Atras', style: TextStyle(fontSize: 18),),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 14,),
              GestureDetector(
                onTap:() {
                  service.guardarCambiosMonumentos(monumentos!);
                  context.go('/');
                },
                child: Container(  
                  height: 30,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.save),
                      Text('Guardar Cambios', style: TextStyle(fontSize:18),),
                    ],),
                ),
              )
            ],
          ),
          SizedBox(height: 50,)
        ],
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
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.monumento.nombre, style: const TextStyle(fontSize: 16)),
            Switch(
              value: widget.monumento.activo,
              onChanged: (bool value) {
                setState(() {
                  widget.monumento.activo = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
