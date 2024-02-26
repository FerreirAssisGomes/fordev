import 'package:equatable/equatable.dart';

import '../protocols/protocols.dart';

class RequiredFieldValidation extends Equatable implements FieldValidation {
  final String field;

  @override
  List get props => [field];

  RequiredFieldValidation(this.field);

  @override
  String validate(String? value) {
    return value?.isNotEmpty == true ? '' : 'campo obrigatório';
  }
}
