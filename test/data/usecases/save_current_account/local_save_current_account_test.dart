import 'package:faker/faker.dart';
import 'package:fordev/domain/entities/account_entity.dart';
import 'package:fordev/domain/helpers/helpers.dart';
import 'package:fordev/domain/usecases/save_current_account.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class LocalSaveCurrentAccount implements SaveCurrentAccount {
  final SaveSecureCacheStorage saveSecureCacheStorage;
  LocalSaveCurrentAccount({required this.saveSecureCacheStorage});
  @override
  Future<void> save(AccountEntity account) async {
    try {
      await saveSecureCacheStorage.saveSecure(
          key: 'token', value: account.token);
    } catch (error) {
      throw DomainError.unexpected;
    }
  }
}

abstract class SaveSecureCacheStorage {
  Future<void> saveSecure({required String key, required String value});
}

class SaveSecureCacheStorageSpy extends Mock implements SaveSecureCacheStorage {
}

void main() {
  test('Should call SaveCacheStorage with correct values', () async {
    final saveSecureCacheStorage = SaveSecureCacheStorageSpy();
    final sut =
        LocalSaveCurrentAccount(saveSecureCacheStorage: saveSecureCacheStorage);
    final account = AccountEntity(faker.guid.guid());
    await sut.save(account);

    verify(
        saveSecureCacheStorage.saveSecure(key: 'token', value: account.token));
  });

  test('Should throw Unexpected SaveCacheStorage throws', () async {
    final saveSecureCacheStorage = SaveSecureCacheStorageSpy();
    final sut =
        LocalSaveCurrentAccount(saveSecureCacheStorage: saveSecureCacheStorage);
    final account = AccountEntity(faker.guid.guid());
    when(saveSecureCacheStorage.saveSecure(
            key: 'token', value: faker.guid.guid()))
        .thenAnswer((_) async => {});
    final future = sut.save(account);

    expect(future, throwsA(DomainError.unexpected));
  });
}
