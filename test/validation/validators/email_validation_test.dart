import 'package:fordev/validation/validators/validators.dart';
import 'package:test/test.dart';

void main() {
  final sut = EmailValidation('any_field');
  test('Should return null if email is empty', () {
    expect(sut.validate(''), '');
  });

  test('Should return null if email is null', () {
    expect(sut.validate(null), '');
  });

  test('Should return null if email is valid', () {
    expect(sut.validate('ferreirassisg@gmail.com'), '');
  });

  test('Should return error if email is invalid', () {
    expect(sut.validate('ferreirassisg.com'), 'Campo inválido');
  });
}
