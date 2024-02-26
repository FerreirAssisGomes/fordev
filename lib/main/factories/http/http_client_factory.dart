import 'package:http/http.dart';
import '../../../infra/http/http.dart';

HttpAdapter makeHttpdapter() {
  final client = Client();
  return HttpAdapter(client);
}
