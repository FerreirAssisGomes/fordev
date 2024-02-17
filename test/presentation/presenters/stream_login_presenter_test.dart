import 'dart:async';

import 'package:faker/faker.dart';
import 'package:fordev/presentation/protocols/validation.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';



class LoginState {
  String emailError;

  LoginState(this.emailError);
}

class StreamLoginPresenter {
  final Validation validation;
  final _controller = StreamController<LoginState>.broadcast();
  final _state = LoginState("error");

  StreamLoginPresenter({required this.validation});

  Stream<String> get emailErrorStream =>
      _controller.stream.map((state) => state.emailError);

  void validateEmail(String email) {
    _state.emailError = validation.validate(field: 'email', value: email)??"";
    _controller.add(_state);
  }
}

class ValidationSpy extends Mock implements Validation {}

void main() {
  final validation = ValidationSpy();
  final sut = StreamLoginPresenter(validation: validation);
  final email = faker.internet.email();

  setUp(() {});

  test('Should call Validation with correct email', () {
    sut.validateEmail(email);
    verify(validation.validate(field: 'email', value: email)).called(1);
  });

  test('Should emit email error if validation fails', () {
    when(validation.validate(field: 'email', value: email)).thenReturn('error');

    expectLater(sut.emailErrorStream, emits('error'));

    sut.validateEmail(email);
  });
}
