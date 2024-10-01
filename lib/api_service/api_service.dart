import 'dart:convert';

import 'package:http/http.dart' as https;

class ApiService{

  Future<Map<String, dynamic>> getDonationCategory(String url) async{
    final response = await https.get(Uri.parse(url));

    if(response.statusCode == 200) {
      final jsonBody = json.decode(response.body) as Map<String, dynamic>;
      return jsonBody;
    } else {
      throw Exception('Failed to load categories');
    }

  }

}