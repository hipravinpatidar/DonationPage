
import 'dart:convert';

DetailsModel detailsModelFromJson(String str) => DetailsModel.fromJson(json.decode(str));

String detailsModelToJson(DetailsModel data) => json.encode(data.toJson());

class DetailsModel {
  int status;
  String message;
  int recode;
  Data data;

  DetailsModel({
    required this.status,
    required this.message,
    required this.recode,
    required this.data,
  });

  factory DetailsModel.fromJson(Map<String, dynamic> json) => DetailsModel(
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
  String enTrustName;
  String hiTrustName;
  String enDescription;
  String hiDescription;
  int id;
  List<String> image;

  Data({
    required this.enTrustName,
    required this.hiTrustName,
    required this.enDescription,
    required this.hiDescription,
    required this.id,
    required this.image,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    enTrustName: json["en_trust_name"],
    hiTrustName: json["hi_trust_name"],
    enDescription: json["en_description"],
    hiDescription: json["hi_description"],
    id: json["id"],
    image: List<String>.from(json["image"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "en_trust_name": enTrustName,
    "hi_trust_name": hiTrustName,
    "en_description": enDescription,
    "hi_description": hiDescription,
    "id": id,
    "image": List<dynamic>.from(image.map((x) => x)),
  };
}





