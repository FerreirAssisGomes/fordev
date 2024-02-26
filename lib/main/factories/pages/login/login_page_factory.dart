import 'package:flutter/cupertino.dart';
import 'package:fordev/data/usecases/usecases.dart';
import 'package:fordev/infra/http/http.dart';
import 'package:fordev/ui/pages/pages.dart';
import 'package:http/http.dart';

import '../../../../presentation/presenters/presenters.dart';
import '../../../../validation/validators/validators.dart';

Widget makeLoginPage() {
  final url = 'http://fordevs.herokuapp.com/api/login';
  final client = Client();
  final httpAdapter = HttpAdapter(client);
  final remoteAuthentication =
      RemoteAuthentication(httpClient: httpAdapter, url: url);
  final validationComposite = ValidationComposite([
    RequiredFieldValidation('email'),
    EmailValidation('email'),
    RequiredFieldValidation('password')
  ]);
  final streamLoginPresenter = StreamLoginPresenter(
      authentication: remoteAuthentication, validation: validationComposite);
  return LoginPage(streamLoginPresenter);
}
