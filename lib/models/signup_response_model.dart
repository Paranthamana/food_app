class SignUpResponseModel{

  bool _isSuccess;
  String _message;

  SignUpResponseModel(this._isSuccess, this._message);
  String get message=> _message;
  bool get isSuccess=> _isSuccess;
}