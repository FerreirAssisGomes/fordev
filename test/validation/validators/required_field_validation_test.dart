import 'package:test/test.dart';

abstract class FieldValidation {
  String get field;
  String validation(String value);
}

class RequiredFieldValidation implements FieldValidation {
  final String field;

  RequiredFieldValidation(this.field);

  @override
  String validation(String? value) {
    return value?.isNotEmpty==true? '':'campo obrigatório';
  }
}

void main() {
  final sut = RequiredFieldValidation('any_field');
  test('should return null if value is not empty', () {
    expect(sut.validation('any_value'), '');
  });

  test('should return error if value is not empty', () {
    expect(sut.validation(''), 'campo obrigatório');
  });

  test('should return error if value is null', () {
    expect(sut.validation(null), 'campo obrigatório');
  });
}
