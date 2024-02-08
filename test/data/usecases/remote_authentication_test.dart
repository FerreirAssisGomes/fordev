import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:fordev/domain/usecases/authentication.dart';

import 'package:fordev/data/http/http.dart';
import 'package:fordev/data/usecases/usecases.dart';

class HttpClientSpy extends Mock implements HttpClient {
  @override
  Future<void> request(
          {required String url, required String method, Map? body}) async =>
      Future.value();
}

void main() {
  RemoteAuthentication? sut;
  HttpClientSpy? httpClient;
  String? url;

  setUp(() {
    httpClient = HttpClientSpy();
    url = faker.internet.httpUrl();
    sut = RemoteAuthentication(httpClient: httpClient!, url: url!);
  });

  test('Should call HttpClient with correct values', () async {
    final params = AuthenticationParams(
        email: faker.internet.email(), secret: faker.internet.password());

    await sut!.auth(params);

    verify(httpClient!.request(
        url: url!,
        method: 'post',
        body: {'email': params.email, 'password': params.secret})).called(1);
  });
}
