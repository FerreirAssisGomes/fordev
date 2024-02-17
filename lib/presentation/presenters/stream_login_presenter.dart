
import 'dart:async';

import '../protocols/protocols.dart';

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