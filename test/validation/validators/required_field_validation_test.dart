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
    return '';
  }
}

void main() {
  test('shouldreturn null if value is not empty', () {
    final sut = RequiredFieldValidation('any_field');
    final error = sut.validation('any_value');
    expect(error, '');
  });
}
