import 'package:fordev/validation/protocols/field_validation.dart';
import 'package:test/test.dart';

class EmailValidation implements FieldValidation {
  final String field;
  EmailValidation(this.field);

  @override
  String validation(String? value) {
    //return value?.isNotEmpty==true? '':'Email inválido';
    return '';
  }
}

void main() {

  test('Should return null if email is empty', () {
    final sut = EmailValidation('any_field');
    final error = sut.validation('');
    expect(error, '');
  });

  test('Should return null if email is null', () {
    final sut = EmailValidation('any_field');
    final error = sut.validation(null);
    expect(error, '');
  });
}
