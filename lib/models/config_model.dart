// To parse this JSON data, do
//
//     final config = configFromJson(jsonString);

import 'dart:convert';

Config configFromJson(String str) => Config.fromJson(json.decode(str));

String configToJson(Config data) => json.encode(data.toJson());

class Config {
    String autores;
    int anio;

    Config({
        required this.autores,
        required this.anio,
    });

    factory Config.fromJson(Map<String, dynamic> json) => Config(
        autores: json["Autores"],
        anio: json["Anio"],
    );

    Map<String, dynamic> toJson() => {
        "Autores": autores,
        "Anio": anio,
    };
}
