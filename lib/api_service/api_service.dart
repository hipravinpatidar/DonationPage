import 'dart:convert';
import 'package:http/http.dart' as https;

class ApiService{

  Future<Map<String, dynamic>> getData(String url) async{
    final response = await https.get(Uri.parse(url));

    if(response.statusCode == 200) {
      final jsonBody = json.decode(response.body) as Map<String, dynamic>;
      return jsonBody;
    } else {
      throw Exception('Failed to load categories');
    }
  }

  Future<Map<String, dynamic>> getAdvertise(String url, Map<String, dynamic> data) async {
    try {
      final response = await https.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body )as Map<String, dynamic>;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Map<String, dynamic>> getSingleData(String url, Map<String, dynamic> data) async {
    try {
      final response = await https.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body )as Map<String, dynamic>;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Future<Map<String, dynamic>> postData(String url, Map<String, dynamic> data) async {
  //   final response = await https.post(Uri.parse(url), body: jsonEncode(data), headers: {
  //     'Content-Type': 'application/json',
  //   });
  //
  //   if (response.statusCode == 200) {
  //     return jsonDecode(response.body);
  //   } else {
  //     throw Exception('Failed to load data');
  //   }
  // }

// Updated getSingleData method
  Future<Map<String, dynamic>> getLeadData(String url, Map<String, dynamic> data) async {
    try {
      final response = await https.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }



}