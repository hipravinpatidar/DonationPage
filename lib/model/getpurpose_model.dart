// To parse this JSON data, do
//
//     final getPurposeModel = getPurposeModelFromJson(jsonString);

import 'dart:convert';

GetPurposeModel getPurposeModelFromJson(String str) => GetPurposeModel.fromJson(json.decode(str));

String getPurposeModelToJson(GetPurposeModel data) => json.encode(data.toJson());

class GetPurposeModel {
  int status;
  String message;
  int recode;
  List<GetPurpose> data;

  GetPurposeModel({
    required this.status,
    required this.message,
    required this.recode,
    required this.data,
  });

  factory GetPurposeModel.fromJson(Map<String, dynamic> json) => GetPurposeModel(
    status: json["status"],
    message: json["message"],
    recode: json["recode"],
    data: List<GetPurpose>.from(json["data"].map((x) => GetPurpose.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "recode": recode,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class GetPurpose {
  String? enName;
  String? hiName;
  int id;
  String? slug;
  String? image;

  GetPurpose({
    required this.enName,
    required this.hiName,
    required this.id,
    required this.slug,
    required this.image,
  });

  factory GetPurpose.fromJson(Map<String, dynamic> json) => GetPurpose(
    enName: json["en_name"],
    hiName: json["hi_name"],
    id: json["id"],
    slug: json["slug"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "en_name": enName ?? '',
    "hi_name": hiName ?? '',
    "id": id,
    "slug": slug ?? '',
    "image": image ?? '',
  };
}
