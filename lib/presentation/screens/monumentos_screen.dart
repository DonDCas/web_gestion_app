import 'package:flutter/material.dart';
import 'package:web_gestion_app/models/monumento_config_model.dart';
import 'package:web_gestion_app/services/monumentos_config_service.dart';

class MonumentosScreen extends StatefulWidget {
  const MonumentosScreen({super.key});

  @override
  State<MonumentosScreen> createState() => _MonumentosScreenState();
}

class _MonumentosScreenState extends State<MonumentosScreen> {
  final MonumentosConfigService configService = MonumentosConfigService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<MonumentoConfig>>(
      future: configService.getMonumentosConfig(),
      builder: (BuildContext context, AsyncSnapshot<List<MonumentoConfig>> snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final monumentos = snapshot.data!;

        return Scaffold(
          appBar: AppBar(title: const Text('Monumentos')),
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: monumentos.length,
                  itemBuilder: (context, index) {
                    return _MonumentCard(monumento: monumentos[index]);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: () {
                    // Aquí puedes implementar la función de guardar cambios
                    print('Guardar cambios');
                  },
                  icon: const Icon(Icons.save),
                  tooltip: 'Guardar cambios',
                ),
              ),
            ],
          ),
        );
      },
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
