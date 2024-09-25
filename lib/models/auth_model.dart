class AuthModel {
  String? token;
  bool? isLoggedIn;

  AuthModel({
    this.token,
    this.isLoggedIn,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      token: json['accessToken'],
      isLoggedIn: json['isLoggedIn'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'isLoggedIn': isLoggedIn,
    };
  }
}
