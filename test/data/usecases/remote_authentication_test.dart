import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';



abstract class HttpClient {
  Future<void> request({required String url});
}

class HttpClientSpy extends Mock implements HttpClient {
  @override
  Future<void> request({required String url}) async => Future.value();
}

class RemoteAuthentication {
  final HttpClient httpClient;
  final String url;

  RemoteAuthentication({required this.httpClient, required this.url});

  Future<void> auth() async {
    await httpClient.request(url: url);
  }
}

void main() {
  final httpClient = HttpClientSpy();
  test('Should call HttpClient with correct URL', () async {
    
    final url = faker.internet.httpUrl();
    final sut = RemoteAuthentication(httpClient: httpClient, url: url);

    await sut.auth();

    verify(httpClient.request(url: url)).called(1);
  });
}


