import 'dart:convert';

import 'package:http/http.dart';
import 'package:web_gestion_app/models/config_model.dart';

class ConfiguracionService {
  final String _url = 'https://ejcalientegrupos2025-default-rtdb.europe-west1.firebasedatabase.app/gestion/Config.json';
  Future<Config?> getConfiguracion() async{
    Uri uri = Uri.parse(_url);
    Response response = await get(uri);
    if (response.statusCode != 200) return null;
    return configFromJson(response.body);
  }

  void guardarCambiosConfiguracion(Config configuracion) async {
    Uri uri = Uri.parse(_url);

    try {
      print(configToJson(configuracion));
      final response = await patch(uri, body: configToJson(configuracion));
      if (response.statusCode == 200) {
        print("Todo ok");
      } else {
        print('${response.statusCode}');
      }
    } catch (e) {
      print('Error al guardar $e');
    }
  }
}