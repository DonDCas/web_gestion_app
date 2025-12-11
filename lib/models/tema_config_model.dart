// To parse this JSON data, do
//
//     final temaConfig = temaConfigFromJson(jsonString);

import 'dart:convert';

TemaConfig temaConfigFromJson(String str) => TemaConfig.fromJson(json.decode(str));

String temaConfigToJson(TemaConfig data) => json.encode(data.toJson());

class TemaConfig {
    int color;
    bool modoOscuro;
    int fontSize;

    TemaConfig({
        required this.color,
        required this.modoOscuro,
        required this.fontSize,
    });

    factory TemaConfig.fromJson(Map<String, dynamic> json) => TemaConfig(
        color: json["Color"],
        modoOscuro: json["ModoOscuro"],
        fontSize: json["fontSize"],
    );

    Map<String, dynamic> toJson() => {
        "Color": color,
        "ModoOscuro": modoOscuro,
        "fontSize": fontSize,
    };
}
