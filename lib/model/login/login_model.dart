class LoginModel {
  final bool? success;
  final String? message;
  final String? token;

  LoginModel({
    this.success,
    this.message,
    this.token,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      token: json['token'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'token': token,
    };
  }
}
