import 'dart:convert';

import 'package:faker/faker.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:fordev/data/http/http.dart';

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
    return jsonDecode(response.body);
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
  final client = ClientSpy();
  final sut = HttpAdapter(client);
  final url = faker.internet.httpUrl();

  group('post', () {
    test('Should call post with correct values', () async {
      when(client.post(Uri.parse(url),body: anyNamed('body'), headers: anyNamed('headers')))
          .thenAnswer((_) async => Response('{"any_key":"any_value"}', 200));

      await sut
          .request(url: url, method: 'post', body: {'any_key': 'any_value'});

      verify(client.post(Uri.parse(url),
          headers: {
            'content-type': 'application/json',
            'accept': 'application/json'
          },
          body: '{"any_key":"any_value"}'));
    });

    test('Should call post without body', () async {
      when(client.post(Uri.parse(url),body: anyNamed('body'), headers: anyNamed('headers')))
          .thenAnswer((_) async => Response('{"any_key":"any_value"}', 200));

      await sut.request(url: url, method: 'post');

      verify(client.post(Uri.parse(url), headers: anyNamed('headers')));
    });

    test('Should return data if post returns 200', () async {
      when(client.post(Uri.parse(url), headers: anyNamed('headers')))
          .thenAnswer((_) async => Response('{"any_key":"any_value"}', 200));
      final response = await sut.request(url: url, method: 'post');

      expect(response, '{"any_key":"any_value"}');
    });
  });
}
