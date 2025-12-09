// To parse this JSON data, do
//
//     final monumentoConfig = monumentoConfigFromJson(jsonString);

import 'dart:convert';

List<MonumentoConfig> monumentoConfigFromJson(String str) => List<MonumentoConfig>.from(json.decode(str).map((x) => MonumentoConfig.fromJson(x)));

String monumentoConfigToJson(List<MonumentoConfig> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MonumentoConfig {
    String? id;
    bool activo;
    int idMonumento;
    String nombre;

    MonumentoConfig({
        this.id,
        required this.activo,
        required this.idMonumento,
        required this.nombre,
    });

    factory MonumentoConfig.fromJson(Map<String, dynamic> json) => MonumentoConfig(
        id: json["id"],
        activo: json["activo"],
        idMonumento: json["idMonumento"],
        nombre: json["nombre"],
    );

    Map<String, dynamic> toJson() => {
        "activo": activo,
        "idMonumento": idMonumento,
        "nombre": nombre,
    };
}
