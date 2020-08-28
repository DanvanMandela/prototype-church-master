import 'package:churchapp/http/http_request/http_request.dart';
import 'package:churchapp/models/Response.dart';

abstract class HttpCallBack {
  void onSuccess(Response response);

  void onError(String error);
}

class HttpResponse {
  HttpCallBack _callBack;
  HttpRequest request = new HttpRequest();

  HttpResponse(this._callBack);

  //Login
  doLogin(String _mobile, String _password) {
    request
        .getLogin(_mobile, _password)
        .then((login) => _callBack.onSuccess(login))
        .catchError((onError) => _callBack.onError(onError.toString()));
  }

  //Sign
  doSign(String _email, String _mobile, String _password) {
    request
        .signUp(_email, _mobile, _password)
        .then((sign) => _callBack.onSuccess(sign))
        .catchError((onError) => _callBack.onError(onError.toString()));
  }

  //Reset Password
  doReset(String _mobile, String _password) {
    request
        .resetPassword(_mobile, _password)
        .then((reset) => _callBack.onSuccess(reset))
        .catchError((onError) => _callBack.onError(onError.toString()));
  }


  //add survey

  doSurvey(
      String username,
      String age,
      String gender,
      String EdLevel,
      String location,
      String microChurch,
      String yrsDcu,
      String child_below_13,
      String child_above_13,
      String prefered_service,
      String prof,
      String employment,
      String business,
      String dep_serve,
      String online_service) {
    request
        .addSurvey(
            username,
            age,
            gender,
            EdLevel,
            location,
            microChurch,
            yrsDcu,
            child_below_13,
            child_above_13,
            prefered_service,
            prof,
            employment,
            business,
            dep_serve,
            online_service)
        .then((survey) => _callBack.onSuccess(survey))
        .catchError((onError) => _callBack.onError(onError.toString()));
  }

  doBook(String service, int seats, int church,String list_seats) {
    request
        .bookSeat(service, seats, church,list_seats)
        .then((book) => _callBack.onSuccess(book))
        .catchError((onError) => _callBack.onError(onError.toString()));
  }
}
