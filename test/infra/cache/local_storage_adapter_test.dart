import 'package:faker/faker.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:fordev/data/cache/cache.dart';

class LocalStorageAdapter implements SaveSecureCacheStorage {
  final FlutterSecureStorage secureStorage;
  LocalStorageAdapter(this.secureStorage);
  Future<void> saveSecure({required String key, required String value}) async {
    await secureStorage.write(key: key, value: value);
  }
}

class FlutterSecureStorageMockSpy extends Mock implements FlutterSecureStorage {
}

void main() {
  final secureStorage = FlutterSecureStorageMockSpy();
  final sut = LocalStorageAdapter(secureStorage);
  final key = faker.lorem.word();
  final value = faker.guid.guid();
  test('Should call save secure with correct values', () async {
    await sut.saveSecure(key: key, value: value);

    verify(secureStorage.write(key: key, value: value));
  });

  test('Should throw if save secure throws', () async {
    when(secureStorage.write(key: key, value: value)).thenThrow(Exception());
    final future = sut.saveSecure(key: key, value: value);

    expect(future, throwsA(TypeMatcher<Exception>()));
  });
}
