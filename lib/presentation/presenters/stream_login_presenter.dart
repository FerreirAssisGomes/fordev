import 'dart:async';

import '../../domain/usecases/authentication.dart';

import '../protocols/protocols.dart';

class LoginState {
  late String email;
  late String password;
  late String emailError;
  late String passwordError;

  bool get isFormValid =>
      emailError != '' && passwordError != '' && email != '' && password != '';
}

class StreamLoginPresenter {
  final Validation validation;
  final _controller = StreamController<LoginState>.broadcast();
  final _state = LoginState();
  final Authentication authentication;

  StreamLoginPresenter(
      {required this.validation, required this.authentication});

  Stream<String> get emailErrorStream =>
      _controller.stream.map((state) => state.emailError).distinct();

  Stream<String> get passwordErrorStream =>
      _controller.stream.map((state) => state.passwordError).distinct();

  Stream<bool> get isFormValidStream =>
      _controller.stream.map((state) => state.isFormValid).distinct();

  void _update() => _controller.add(_state);

  void validateEmail(String email) {
    _state.email = email;
    _state.emailError = validation.validate(field: 'email', value: email) ?? "";
    _update();
  }

  void validatePassword(String password) {
    _state.password = password;
    _state.passwordError =
        validation.validate(field: 'password', value: password) ?? "";
    _update();
  }

  Future<void> auth() async {
    await authentication.auth(
        AuthenticationParams(email: _state.email, secret: _state.password));
  }
}
