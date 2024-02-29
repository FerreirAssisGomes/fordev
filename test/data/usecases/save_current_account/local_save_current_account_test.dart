import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:fordev/domain/entities/account_entity.dart';
import 'package:fordev/domain/helpers/helpers.dart';

import 'package:fordev/data/cache/cache.dart';
import 'package:fordev/data/usecases/usecases.dart';



class SaveSecureCacheStorageSpy extends Mock implements SaveSecureCacheStorage {
}

void main() {
  final saveSecureCacheStorage = SaveSecureCacheStorageSpy();
  final sut =
      LocalSaveCurrentAccount(saveSecureCacheStorage: saveSecureCacheStorage);
  final account = AccountEntity(faker.guid.guid());
  test('Should call SaveCacheStorage with correct values', () async {
    await sut.save(account);
    verify(
        saveSecureCacheStorage.saveSecure(key: 'token', value: account.token));
  });

  test('Should throw Unexpected SaveCacheStorage throws', () async {
    when(saveSecureCacheStorage.saveSecure(
            key: 'token', value: faker.guid.guid()))
        .thenThrow(Exception());
    final future = sut.save(account);
    expect(future, throwsA(DomainError.unexpected));
  });
}
