import 'package:test/test.dart';

abstract class FieldValidation {
  String get field;
  String validation(String value);
}

class RequiredFieldValidation implements FieldValidation {
  final String field;

  RequiredFieldValidation(this.field);

  @override
  String validation(String value) {
    return value.isEmpty? 'campo obrigatório': '';
  }
}

void main() {
  test('should return null if value is not empty', () {
    final sut = RequiredFieldValidation('any_field');
    final error = sut.validation('any_value');
    expect(error, '');
  });

  test('should return error if value is not empty', () {
    final sut = RequiredFieldValidation('any_field');
    final error = sut.validation('');
    expect(error, 'campo obrigatório');
  });
}
