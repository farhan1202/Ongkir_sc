// To parse this JSON data, do
//
//     final city = cityFromJson(jsonString);

import 'dart:convert';

City cityFromJson(String str) => City.fromJson(json.decode(str));

String cityToJson(City data) => json.encode(data.toJson());

class City {
  City({
    this.rajaongkir,
  });

  Rajaongkir? rajaongkir;

  factory City.fromJson(Map<String, dynamic> json) => City(
        rajaongkir: Rajaongkir.fromJson(json["rajaongkir"]),
      );

  Map<String, dynamic> toJson() => {
        "rajaongkir": rajaongkir!.toJson(),
      };
}

class Rajaongkir {
  Rajaongkir({
    this.query,
    this.status,
    this.results,
  });

  List<dynamic>? query;
  Status? status;
  List<ResultCity>? results;

  factory Rajaongkir.fromJson(Map<String, dynamic> json) => Rajaongkir(
        query: List<dynamic>.from(json["query"].map((x) => x)),
        status: Status.fromJson(json["status"]),
        results: List<ResultCity>.from(
            json["results"].map((x) => ResultCity.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "query": List<dynamic>.from(query!.map((x) => x)),
        "status": status!.toJson(),
        "results": List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class ResultCity {
  ResultCity({
    this.cityId,
    this.provinceId,
    this.province,
    this.type,
    this.cityName,
    this.postalCode,
  });

  String? cityId;
  String? provinceId;
  String? province;
  String? type;
  String? cityName;
  String? postalCode;

  factory ResultCity.fromJson(Map<String, dynamic> json) => ResultCity(
        cityId: json["city_id"],
        provinceId: json["province_id"],
        province: json["province"],
        type: json["type"],
        cityName: json["city_name"],
        postalCode: json["postal_code"],
      );

  Map<String, dynamic> toJson() => {
        "city_id": cityId,
        "province_id": provinceId,
        "province": province,
        "type": type,
        "city_name": cityName,
        "postal_code": postalCode,
      };
}

class Status {
  Status({
    this.code,
    this.description,
  });

  int? code;
  String? description;

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        code: json["code"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "description": description,
      };
}
