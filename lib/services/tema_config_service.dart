import 'dart:convert';
import 'package:http/http.dart';
import 'package:web_gestion_app/models/tema_config_model.dart';

class TemaConfigService {
  final String _endPoint = "https://ejcalientegrupos2025-default-rtdb.europe-west1.firebasedatabase.app/gestion/Tema.json";
  Future<TemaConfig?> getTema() async{

    TemaConfig temaConfig = TemaConfig(color: '000000', modoOscuro: false, fontSize: 18);

    Uri uri = Uri.parse(_endPoint);
    Response response = await get(uri);

    if (response.statusCode != 200) return null;

    final data = jsonDecode(response.body);

    if(data is Map<String, dynamic>){
      temaConfig = TemaConfig.fromJson(data);
    }

    return temaConfig;
  }


  Future<void> guardarTema(TemaConfig tema) async {
    final Uri uri = Uri.parse(_endPoint);

    try {
      final response = await patch(
        uri,
        body: jsonEncode(tema.toJson()),
      );

      if (response.statusCode == 200) {
        print("Tema actualizado correctamente");
      } else {
        print("Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Error al guardar tema: $e");
    }
  }
}
