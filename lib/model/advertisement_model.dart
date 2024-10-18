// To parse this JSON data, do
//
//     final advertisementModel = advertisementModelFromJson(jsonString);

import 'dart:convert';

AdvertisementModel advertisementModelFromJson(String str) => AdvertisementModel.fromJson(json.decode(str));

String advertisementModelToJson(AdvertisementModel data) => json.encode(data.toJson());

// class AdvertisementModel {
//   int status;
//   String message;
//   int recode;
//   List<AdvertiseMent> data;
//
//   AdvertisementModel({
//     required this.status,
//     required this.message,
//     required this.recode,
//     required this.data,
//   });
//
//   factory AdvertisementModel.fromJson(Map<String, dynamic> json) => AdvertisementModel(
//     status: json["status"],
//     message: json["message"],
//     recode: json["recode"],
//     data: List<AdvertiseMent>.from(json["data"].map((x) => AdvertiseMent.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "status": status,
//     "message": message,
//     "recode": recode,
//     "data": List<dynamic>.from(data.map((x) => x.toJson())),
//   };
// }
//
// class AdvertiseMent {
//   String? enName;
//   String? hiName;
//   String? enDescription;
//   String? hiDescription;
//   int id;
//   String? image;
//
//   AdvertiseMent({
//     required this.enName,
//     required this.hiName,
//     required this.enDescription,
//     required this.hiDescription,
//     required this.id,
//     required this.image,
//   });
//
//   factory AdvertiseMent.fromJson(Map<String, dynamic> json) => AdvertiseMent(
//     enName: json["en_name"],
//     hiName: json["hi_name"],
//     enDescription: json["en_description"],
//     hiDescription: json["hi_description"],
//     id: json["id"],
//     image: json["image"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "en_name": enName ?? '',
//     "hi_name": hiName ?? '',
//     "en_description": enDescription ?? '',
//     "hi_description": hiDescription ?? '',
//     "id": id,
//     "image": image ?? '',
//   };
// }

class AdvertisementModel {
  int status;
  String message;
  int recode;
  List<AdvertiseMent> data;

  AdvertisementModel({
    required this.status,
    required this.message,
    required this.recode,
    required this.data,
  });

  factory AdvertisementModel.fromJson(Map<String, dynamic> json) => AdvertisementModel(
    status: json["status"],
    message: json["message"],
    recode: json["recode"],
    data: List<AdvertiseMent>.from(json["data"].map((x) => AdvertiseMent.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "recode": recode,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class AdvertiseMent {
  String? enName;
  String? hiName;
  String? enDescription;
  String? hiDescription;
  int id;
  String? image;

  AdvertiseMent({
    this.enName,
    this.hiName,
    this.enDescription,
    this.hiDescription,
    required this.id,
    this.image,
  });

  factory AdvertiseMent.fromJson(Map<String, dynamic> json) => AdvertiseMent(
    enName: json["en_name"] ?? '',
    hiName: json["hi_name"] ?? '',
    enDescription: json["en_description"] ?? '',
    hiDescription: json["hi_description"] ?? '',
    id: json["id"],
    image: json["image"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "en_name": enName ?? '',
    "hi_name": hiName ?? '',
    "en_description": enDescription ?? '',
    "hi_description": hiDescription ?? '',
    "id": id,
    "image": image ?? '',
  };
}