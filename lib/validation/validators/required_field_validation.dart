import '../protocols/protocols.dart';

class RequiredFieldValidation implements FieldValidation {
  final String field;

  RequiredFieldValidation(this.field);

  @override
  String validation(String? value) {
    return value?.isNotEmpty==true? '':'campo obrigatório';
  }
}