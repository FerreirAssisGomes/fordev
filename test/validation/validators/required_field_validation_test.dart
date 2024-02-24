import 'package:test/test.dart';
import 'package:fordev/validation/validators/validators.dart';

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
