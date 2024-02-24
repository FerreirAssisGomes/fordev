import 'package:fordev/validation/validators/validators.dart';
import 'package:test/test.dart';

void main() {
  final sut = EmailValidation('any_field');
  test('Should return null if email is empty', () {
    expect(sut.validation(''), '');
  });

  test('Should return null if email is null', () {
    expect(sut.validation(null), '');
  });

  test('Should return null if email is valid', () {
    expect(sut.validation('ferreirassisg@gmail.com'), '');
  });

  test('Should return error if email is invalid', () {
    expect(sut.validation('ferreirassisg.com'), 'Campo inválido');
  });
}
