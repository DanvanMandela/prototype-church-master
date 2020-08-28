import 'package:churchapp/models/Response.dart';

abstract class ChurchAPI {
  Future<List<Response>> getUser();
  Future<List<Response>> getUserDetails();
}
