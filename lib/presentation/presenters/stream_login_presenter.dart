import 'dart:async';

import '../protocols/protocols.dart';

class LoginState {
  late String emailError;
  bool get isFormValid => false;
}

class StreamLoginPresenter {
  final Validation validation;
  final _controller = StreamController<LoginState>.broadcast();
  final _state = LoginState();

  StreamLoginPresenter({required this.validation});

  Stream<String> get emailErrorStream =>
      _controller.stream.map((state) => state.emailError).distinct();

  Stream<bool> get isFormValidStream =>
      _controller.stream.map((state) => state.isFormValid).distinct();

  void validateEmail(String email) {
    _state.emailError = validation.validate(field: 'email', value: email) ?? "";
    _controller.add(_state);
  }
}
