import 'package:fordev/validation/protocols/field_validation.dart';
import 'package:test/test.dart';

class EmailValidation implements FieldValidation {
  final String field;
  EmailValidation(this.field);

  @override
  String validation(String? value) {
    final regex = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    final isValid = value?.isNotEmpty != true || regex.hasMatch(value!);
    return isValid ? '' : 'Campo inválido';
  }
}

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
