import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:fordev/domain/usecases/authentication.dart';

import 'package:fordev/presentation/presenters/presenters.dart';
import 'package:fordev/presentation/protocols/protocols.dart';

class ValidationSpy extends Mock implements Validation {}

class AuthenticationSpy extends Mock implements Authentication {
  
}

void main() {
  final validation = ValidationSpy();
  final email = faker.internet.email();
  final password = faker.internet.password();
  AuthenticationSpy authentication = AuthenticationSpy();
  final sut = StreamLoginPresenter(validation: validation,authentication:authentication);

  setUp(() {});

  test('Should call Validation with correct email', () {
    sut.validateEmail(email);
    verify(validation.validate(field: 'email', value: email)).called(1);
  });

  test('Should emit email error if validation fails', () {
    when(validation.validate(field: 'email', value: email)).thenReturn('error');

    sut.emailErrorStream
        .listen(expectAsync1((error) => expect(error, 'error')));

    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateEmail(email);

    sut.validateEmail(email);
  });

  test('Should emit email null if validation succeeds', () {
    sut.emailErrorStream.listen(expectAsync1((error) => expect(error, '')));

    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateEmail(email);

    sut.validateEmail(email);
  });

  test('Should call Validation with correct password', () {
    sut.validatePassword(password);
    verify(validation.validate(field: 'password', value: password)).called(1);
  });

  test('Should emit password error if validation fails', () {
    when(validation.validate(field: 'password', value: password))
        .thenReturn('error');

    sut.passwordErrorStream
        .listen(expectAsync1((error) => expect(error, 'error')));

    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validatePassword(password);

    sut.validatePassword(password);
  });

  test('Should emit password null if validation succeeds', () {
    sut.passwordErrorStream.listen(expectAsync1((error) => expect(error, '')));

    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validatePassword(password);

    sut.validatePassword(password);
  });

  test('Should emit password null if validation success', () async {
    sut.emailErrorStream.listen(expectAsync1((error) => expect(error, '')));
    sut.passwordErrorStream.listen(expectAsync1((error) => expect(error, '')));
    expectLater(sut.isFormValidStream, emitsInOrder([false, true]));

    sut.validateEmail(email);
    await Future.delayed(Duration.zero);
    sut.validatePassword(password);
  });

  test('Should call authentication with correct values', () async {
    sut.validateEmail(email);
    sut.validatePassword(password);

    await sut.auth();

    verify(authentication
            .auth(AuthenticationParams(email: email, secret: password)))
        .called(1);
  });
}
