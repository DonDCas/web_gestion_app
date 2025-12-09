import 'package:flutter/material.dart';
import 'package:web_gestion_app/services/monumentos_config_service.dart';

class MonumentosScreen extends StatefulWidget {
  const MonumentosScreen({super.key});

  @override
  State<MonumentosScreen> createState() => _MonumentosScreenState();
}

class _MonumentosScreenState extends State<MonumentosScreen> {
  @override
  Widget build(BuildContext context) {
    MonumentosConfigService config = MonumentosConfigService();
    return const Placeholder();
  }
}