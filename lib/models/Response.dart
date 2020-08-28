class Response {
  bool _error;
  String _message;
  Map _user;
  Map _church;
  Map _booked;
  Map _response;

  Response(this._error, this._message, this._user, this._church, this._booked,
      this._response);

  Response.fromLoginResponse(dynamic obj) {
    this._error = obj['error'];
    this._message = obj['message'];
    this._user = obj['user'];
  }

  Response.fromResetPasswordResponse(dynamic obj) {
    this._error = obj['error'];
    this._message = obj['message'];
    this._user = obj['user'];
  }

  Response.fromChurchResponse(dynamic obj) {
    this._error = obj['error'];
    this._message = obj['message'];
    this._church = obj['church'];
  }

  Response.fromBookedResponse(dynamic obj) {
    this._error = obj['error'];
    this._message = obj['message'];
    this._booked = obj['booked'];
  }

  Response.fromResponse(dynamic obj) {
    this._error = obj['error'];
    this._message = obj['message'];
  }

  Map get response => _response;

  set response(Map value) {
    _response = value;
  }

  Map get booked => _booked;

  set booked(Map value) {
    _booked = value;
  }

  Map get church => _church;

  set church(Map value) {
    _church = value;
  }

  Map get user => _user;

  set user(Map value) {
    _user = value;
  }

  String get message => _message;

  set message(String value) {
    _message = value;
  }

  bool get error => _error;

  set error(bool value) {
    _error = value;
  }
}
