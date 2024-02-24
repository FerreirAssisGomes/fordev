import 'package:test/test.dart';
import 'package:fordev/validation/validators/validators.dart';

void main() {
  final sut = RequiredFieldValidation('any_field');
  test('should return null if value is not empty', () {
    expect(sut.validate('any_value'), '');
  });

  test('should return error if value is not empty', () {
    expect(sut.validate(''), 'campo obrigatório');
  });

  test('should return error if value is null', () {
    expect(sut.validate(null), 'campo obrigatório');
  });
}
