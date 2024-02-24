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
}
