import 'dart:convert';

import 'package:faker/faker.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class HttpAdapter {
  final Client client;
  final headers = {
    'content-type': 'application/json',
    'accept': 'application/json'
  };
  HttpAdapter(this.client);
  Future<void> request({required String url, required String method, Map? body}) async {
    await client.post(Uri.parse(url), headers: headers, body: jsonEncode(body));
  }
}

class ClientSpy extends Mock implements Client {
  @override
  Future<Response> post(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    return Response('Test response body', 200);
  }
}

void main() {
  group('post', () {
    test('Should call post with correct values', () async {
      final client = ClientSpy();
      final sut = HttpAdapter(client);
      final url = faker.internet.httpUrl();

      await sut.request(url: url, method: 'post', body:{'any_key':'any_value'});

      verify(client.post(
        Uri.parse(url), 
        headers: {
        'content-type': 'application/json',
        'accept': 'application/json'
      },
      body: '{"any_key":"any_value"}'
      ));
    });
  });
}
