import 'package:test/test.dart';
import 'package:fordev/main/factories/factories.dart';
import 'package:fordev/validation/validators/validators.dart';

void main() {
  test('Should return the correct validations', () {
    final validations = makeLoginValidations();
    expect(validations, [
      RequiredFieldValidation('email'),
      EmailValidation('email'),
      RequiredFieldValidation('password')
    ]);
  });
}
