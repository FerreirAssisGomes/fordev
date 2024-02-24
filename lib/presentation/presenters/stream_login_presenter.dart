import 'dart:async';

import '../protocols/protocols.dart';

class LoginState {
  late String emailError;
  late String passwordError;
  bool get isFormValid => false;
}

class StreamLoginPresenter {
  final Validation validation;
  final _controller = StreamController<LoginState>.broadcast();
  final _state = LoginState();

  StreamLoginPresenter({required this.validation});

  Stream<String> get emailErrorStream =>
      _controller.stream.map((state) => state.emailError).distinct();

  Stream<String> get PasswordErrorStream =>
      _controller.stream.map((state) => state.passwordError).distinct();

  Stream<bool> get isFormValidStream =>
      _controller.stream.map((state) => state.isFormValid).distinct();

void _update()=> _controller.add(_state);
  void validateEmail(String email) {
    _state.emailError = validation.validate(field: 'email', value: email) ?? "";
     _update();
  }

  void validatePassword(String password) {
    _state.passwordError =
        validation.validate(field: 'password', value: password) ?? "";
    _update();
  }
}
