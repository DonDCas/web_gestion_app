// To parse this JSON data, do
//
//     final itemResponse = itemResponseFromJson(jsonString);

import 'dart:convert';

RutaConfig itemResponseFromJson(String str) => RutaConfig.fromJson(json.decode(str));

String itemResponseToJson(RutaConfig data) => json.encode(data.toJson());

class RutaConfig {
    String? id;
    bool active;
    String link;
    String titulo;

    RutaConfig({
        required this.active,
        required this.link,
        required this.titulo,
    });

    factory RutaConfig.fromJson(Map<String, dynamic> json) => RutaConfig(
        active: json["active"],
        link: json["link"],
        titulo: json["titulo"],
    );

    Map<String, dynamic> toJson() => {
        "active": active,
        "link": link,
        "titulo": titulo,
    };
}
