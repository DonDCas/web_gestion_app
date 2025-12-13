import 'dart:convert';

import 'package:http/http.dart';
import 'package:web_gestion_app/models/ruta_config_model.dart';

class RutasConfigService {
  final String _url = "https://ejcalientegrupos2025-default-rtdb.europe-west1.firebasedatabase.app/gestion/rutas.json";
  Future<List<RutaConfig>> getRutasConfig() async {
    List<RutaConfig> result = [];

    try {
      Uri uri = Uri.parse(_url);
      Response response = await get(uri);
      print(response.statusCode);
      if (response.statusCode != 200) return [];

      final data = jsonDecode(response.body);
      if (data is Map<String, dynamic>) {
        data.forEach((key, value) {
          
          RutaConfig temp = RutaConfig.fromJson(value);
          temp.id = key; 
          result.add(temp);
        });
      }else if (data is List) {
        for (var value in data) {
          RutaConfig temp = RutaConfig.fromJson(value);
          result.add(temp);
        }
      }
    } catch (e) {
      print('Error al parsear JSON: $e');
      return [];
    }
    return result;
  }

  void guardarCambiosRutas(List<RutaConfig> rutas) async {
    Uri uri = Uri.parse(_url);

    final Map<String, dynamic> updates = {
      for (var ruta in rutas) ruta.id.toString(): ruta.toJson(),
    };

    try {
      final respones = await patch(uri, body: jsonEncode(updates));
      if (respones.statusCode == 200) {
        print("Todo ok");
      } else {
        print('${respones.statusCode}');
      }
    } catch (e) {
      print('Error al guardar $e');
    }
  }
}