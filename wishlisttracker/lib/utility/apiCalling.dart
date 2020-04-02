import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiCalling {
  static String endpoint = "https://99fce215.ngrok.io";

  static Future<dynamic> getReq(urlPath) async {
    try {
      var response = await http.Client().get('$endpoint/$urlPath');
      return response.body;
    } catch (err) {
      print(err);
      return {};
    }
  }

  static Future<dynamic> postReq(urlPath, reqBody) async {
    var responseBody;
    try {
      //encode Map to JSON
      reqBody = json.encode(reqBody);
      var response = await http.Client().post('$endpoint/$urlPath',
          headers: {"Content-Type": "application/json"}, body: reqBody);

      responseBody =
          response.statusCode != 500 ? json.decode(response.body) : null;
      return responseBody;
    } catch (err) {
      print(err);
      return responseBody;
    }
  }
}
