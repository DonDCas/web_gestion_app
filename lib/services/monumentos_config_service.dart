import 'dart:convert';
import 'package:web_gestion_app/models/monumento_config_model.dart';
import 'package:http/http.dart';

class MonumentosConfigService {
  final String _endPoint =
      "https://ejcalientegrupos2025-default-rtdb.europe-west1.firebasedatabase.app/gestion/monumentos.json";
  Future<List<MonumentoConfig>> getMonumentosConfig() async {
    List<MonumentoConfig> result = [];

    try {
      Uri uri = Uri.parse(_endPoint);
      Response response = await get(uri);
      print(response.statusCode);
      if (response.statusCode != 200) return [];

      final data = jsonDecode(response.body);
      if (data is Map<String, dynamic>) {
        data.forEach((key, value) {
          
          MonumentoConfig temp = MonumentoConfig.fromJson(value);
          temp.id = key; 
          result.add(temp);
        });
      }else if (data is List) {
        for (var value in data) {
          MonumentoConfig temp = MonumentoConfig.fromJson(value);
          result.add(temp);
        }
      }
    } catch (e) {
      print('Error al parsear JSON: $e');
      return [];
    }
    return result;
  }

  void guardarCambiosMonumentos(List<MonumentoConfig> monumentos) async {
    Uri uri = Uri.parse(_endPoint);

    final Map<String, dynamic> updates = {
      for (var monumento in monumentos) monumento.idMonumento.toString(): monumento.toJson(),
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
