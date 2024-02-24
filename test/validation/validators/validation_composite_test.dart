import 'package:fordev/presentation/protocols/protocols.dart';
import 'package:fordev/validation/protocols/protocols.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class ValidationComposite implements Validation {
  final List<FieldValidation> validations;

  ValidationComposite(this.validations);

  @override
  String validate({required String field, required String value}) {
    String error = '';
    for (final validation in validations.where((element) => element.field==field)) {
      error = validation.validate(value);
      if(error.isNotEmpty==true){
        return error;
      }
    }
    return error;
  }
}

class FieldValidationSpy extends Mock implements FieldValidation {}

void main() {
  final validation1 = FieldValidationSpy();
  final validation2 = FieldValidationSpy();
  final validation3 = FieldValidationSpy();
  final sut = ValidationComposite([validation1, validation2, validation3]);

  test('Should return null if all validations returns null or empty', () {
    when(validation1.field).thenReturn('any_field');
    when(validation1.validate('')).thenReturn('');

    when(validation2.field).thenReturn('any_field');
    when(validation2.validate('')).thenReturn('');

    when(validation3.field).thenReturn('other_field');
    when(validation3.validate('')).thenReturn('');

    final error = sut.validate(field: 'any_filed', value: '');
    expect(error, '');
  });

  test('Should return the first error', () {
    when(validation1.field).thenReturn('any_field');
    when(validation1.validate('')).thenReturn('error_1');

    when(validation2.field).thenReturn('any_field');
    when(validation2.validate('')).thenReturn('error_2');

    final error = sut.validate(field: 'any_filed', value: '');
    expect(error, 'error_1');
  });

  
  test('Should return the first error', () {
    when(validation1.field).thenReturn('other_field');
    when(validation1.validate('')).thenReturn('error_1');

    when(validation2.field).thenReturn('any_field');
    when(validation2.validate('')).thenReturn('error_2');

    final error = sut.validate(field: 'any_filed', value: '');
    expect(error, 'error_1');
  });
}
