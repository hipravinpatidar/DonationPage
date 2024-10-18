// // To parse this JSON data, do
// //
// //     final donationPageModel = donationPageModelFromJson(jsonString);
//
// import 'dart:convert';
//
// DonationPageModel donationPageModelFromJson(String str) => DonationPageModel.fromJson(json.decode(str));
//
// String donationPageModelToJson(DonationPageModel data) => json.encode(data.toJson());
//
// class DonationPageModel {
//   int status;
//   String message;
//   int recode;
//   Data data;
//
//   DonationPageModel({
//     required this.status,
//     required this.message,
//     required this.recode,
//     required this.data,
//   });
//
//   factory DonationPageModel.fromJson(Map<String, dynamic> json) => DonationPageModel(
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
//   String enName;
//   String hiName;
//   String enDescription;
//   String hiDescription;
//   String enTrustName;
//   String hiTrustName;
//   int id;
//   String image;
//
//   Data({
//     required this.enName,
//     required this.hiName,
//     required this.enDescription,
//     required this.hiDescription,
//     required this.enTrustName,
//     required this.hiTrustName,
//     required this.id,
//     required this.image,
//   });
//
//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//     enName: json["en_name"],
//     hiName: json["hi_name"],
//     enDescription: json["en_description"],
//     hiDescription: json["hi_description"],
//     enTrustName: json["en_trust_name"],
//     hiTrustName: json["hi_trust_name"],
//     id: json["id"],
//     image: json["image"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "en_name": enName,
//     "hi_name": hiName,
//     "en_description": enDescription,
//     "hi_description": hiDescription,
//     "en_trust_name": enTrustName,
//     "hi_trust_name": hiTrustName,
//     "id": id,
//     "image": image,
//   };
// }


// To parse this JSON data, do
//
//     final donationPageModel = donationPageModelFromJson(jsonString);

import 'dart:convert';

DonationPageModel donationPageModelFromJson(String str) => DonationPageModel.fromJson(json.decode(str));

String donationPageModelToJson(DonationPageModel data) => json.encode(data.toJson());

class DonationPageModel {
  int status;
  String message;
  int recode;
  Data data;

  DonationPageModel({
    required this.status,
    required this.message,
    required this.recode,
    required this.data,
  });

  factory DonationPageModel.fromJson(Map<String, dynamic> json) => DonationPageModel(
    status: json["status"],
    message: json["message"],
    recode: json["recode"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "recode": recode,
    "data": data.toJson(),
  };
}

class Data {
  String enName;
  String hiName;
  String enDescription;
  String hiDescription;
  String setType;
  int setAmount;
  String setTitle;
  int setNumber;
  String setUnit;
  String enTrustName;
  String hiTrustName;
  int id;
  String image;

  Data({
    required this.enName,
    required this.hiName,
    required this.enDescription,
    required this.hiDescription,
    required this.setType,
    required this.setAmount,
    required this.setTitle,
    required this.setNumber,
    required this.setUnit,
    required this.enTrustName,
    required this.hiTrustName,
    required this.id,
    required this.image,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    enName: json["en_name"],
    hiName: json["hi_name"],
    enDescription: json["en_description"],
    hiDescription: json["hi_description"],
    setType: json["set_type"],
    setAmount: json["set_amount"],
    setTitle: json["set_title"],
    setNumber: json["set_number"],
    setUnit: json["set_unit"],
    enTrustName: json["en_trust_name"],
    hiTrustName: json["hi_trust_name"],
    id: json["id"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "en_name": enName,
    "hi_name": hiName,
    "en_description": enDescription,
    "hi_description": hiDescription,
    "set_type": setType,
    "set_amount": setAmount,
    "set_title": setTitle,
    "set_number": setNumber,
    "set_unit": setUnit,
    "en_trust_name": enTrustName,
    "hi_trust_name": hiTrustName,
    "id": id,
    "image": image,
  };
}
