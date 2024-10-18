// To parse this JSON data, do
//
//     final leadDetailsModel = leadDetailsModelFromJson(jsonString);

// import 'dart:convert';
//
// LeadDetailsModel leadDetailsModelFromJson(String str) => LeadDetailsModel.fromJson(json.decode(str));
//
// String leadDetailsModelToJson(LeadDetailsModel data) => json.encode(data.toJson());
//
// class LeadDetailsModel {
//   int status;
//   String message;
//   int recode;
//   Data data;
//
//   LeadDetailsModel({
//     required this.status,
//     required this.message,
//     required this.recode,
//     required this.data,
//   });
//
//   factory LeadDetailsModel.fromJson(Map<String, dynamic> json) => LeadDetailsModel(
//     status: json["status"],
//     message: json["message"],
//     recode: json["recode"],
//     data: Data.fromJson(json["data"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "status": status,
//     "message": message,
//     "recode": recode,
//     "data": data.toJson(),
//   };
// }
//
// class Data {
//   String id;
//
//   Data({
//     required this.id,
//   });
//
//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//     id: json["id"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//   };
// }


import 'dart:convert';
import 'package:http/http.dart' as http;

LeadDetailsModel leadDetailsModelFromJson(String str) => LeadDetailsModel.fromJson(json.decode(str));

String leadDetailsModelToJson(LeadDetailsModel data) => json.encode(data.toJson());

class LeadDetailsModel {
  int status;
  String message;
  int recode;
  Data? data;  // Made nullable in case 'data' is missing

  LeadDetailsModel({
    required this.status,
    required this.message,
    required this.recode,
    this.data,
  });

  factory LeadDetailsModel.fromJson(Map<String, dynamic> json) => LeadDetailsModel(
    status: json["status"] ?? 0,
    message: json["message"] ?? '',
    recode: json["recode"] ?? 0,
    data: json["data"] != null ? Data.fromJson(json["data"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "recode": recode,
    "data": data?.toJson(),
  };
}

class Data {
  String? id; // Made nullable in case 'id' is missing

  Data({
    this.id,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"] ?? '', // Provide a default empty string if null
  );

  Map<String, dynamic> toJson() => {
    "id": id,
  };
}