// To parse this JSON data, do
//
//     final successAmount = successAmountFromJson(jsonString);

import 'dart:convert';

SuccessAmount successAmountFromJson(String str) => SuccessAmount.fromJson(json.decode(str));

String successAmountToJson(SuccessAmount data) => json.encode(data.toJson());

class SuccessAmount {
  int status;
  String message;
  int recode;
  List<dynamic> data;

  SuccessAmount({
    required this.status,
    required this.message,
    required this.recode,
    required this.data,
  });

  factory SuccessAmount.fromJson(Map<String, dynamic> json) => SuccessAmount(
    status: json["status"],
    message: json["message"],
    recode: json["recode"],
    data: List<dynamic>.from(json["data"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "recode": recode,
    "data": List<dynamic>.from(data.map((x) => x)),
  };
}
