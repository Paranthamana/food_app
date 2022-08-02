class SignUpBody{

  //---crate how many data sending to server
  String name;
  String mobile;
  String email;
  String password;

  SignUpBody({
      required this.name,
      required this.mobile,
      required this.email,
      required this.password});

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["f_name"] = this.name;
    data["phone"] = this.mobile;
    data["email"] = this.email;
    data["password"] = this.password;
    return data;
  }
}