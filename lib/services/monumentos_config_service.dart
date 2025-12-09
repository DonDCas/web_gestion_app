import 'dart:convert';

import 'package:web_gestion_app/models/monumento_config_model.dart';
import 'package:http/http.dart';

class MonumentosConfigService{
  final String _endPoint ="https://ejcalientegrupos2025-default-rtdb.europe-west1.firebasedatabase.app/gestion/monumentos.json";
  Future<List<MonumentoConfig>> getMonumentosConfig() async {
    List<MonumentoConfig> result = [];

    Uri uri = Uri.parse(_endPoint);
    Response response = await get(uri);
    if (response.statusCode != 200) return [];

    final data = jsonDecode(response.body);

    data.forEach((id, objeto){
      MonumentoConfig temp = MonumentoConfig.fromJson(objeto);
      temp.id = id;
      result.add(temp);
      print(temp);
    });

    return result;
  }
}