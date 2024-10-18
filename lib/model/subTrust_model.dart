// To parse this JSON data, do
//
//     final subTrustModel = subTrustModelFromJson(jsonString);

import 'dart:convert';

SubTrustModel subTrustModelFromJson(String str) => SubTrustModel.fromJson(json.decode(str));

String subTrustModelToJson(SubTrustModel data) => json.encode(data.toJson());

class SubTrustModel {
  int status;
  String message;
  int recode;
  List<SubTrust> data;

  SubTrustModel({
    required this.status,
    required this.message,
    required this.recode,
    required this.data,
  });

  factory SubTrustModel.fromJson(Map<String, dynamic> json) => SubTrustModel(
    status: json["status"],
    message: json["message"],
    recode: json["recode"],
    data: List<SubTrust>.from(json["data"].map((x) => SubTrust.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "recode": recode,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class SubTrust {
  String enTrustName;
  String hiTrustName;
  String enDescription;
  String hiDescription;
  int id;
  String image;

  SubTrust({
    required this.enTrustName,
    required this.hiTrustName,
    required this.enDescription,
    required this.hiDescription,
    required this.id,
    required this.image,
  });

  factory SubTrust.fromJson(Map<String, dynamic> json) => SubTrust(
    enTrustName: json["en_trust_name"],
    hiTrustName: json["hi_trust_name"],
    enDescription: json["en_description"],
    hiDescription: json["hi_description"],
    id: json["id"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "en_trust_name": enTrustName,
    "hi_trust_name": hiTrustName,
    "en_description": enDescription,
    "hi_description": hiDescription,
    "id": id,
    "image": image,
  };
}
