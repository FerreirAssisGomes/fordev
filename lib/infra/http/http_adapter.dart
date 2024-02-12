import 'dart:convert';

import 'package:http/http.dart';

import '../../data/http/http.dart';

class HttpAdapter implements HttpClient {
  final Client client;
  final headers = {
    'content-type': 'application/json',
    'accept': 'application/json'
  };
  HttpAdapter(this.client);
  Future<Map> request(
      {required String url, required String method, Map? body}) async {
    final jsonBody = body != null ? jsonEncode(body) : null;
    final response =
        await client.post(Uri.parse(url), headers: headers, body: jsonBody);
    if (response.statusCode == 200) {
      return response.body.isEmpty ? null : jsonDecode(response.body);
    } else {
      return {};
    }
  }
}