class UserModel {
  final String email;
  final String password;
  final String serverKey;

  // Optional Fields
  final String? username;
  final String? firstName;
  final String? lastName;
  final String? phone;
  final String? confirmPassword;
  final String? gender;

  UserModel({
    required this.email,
    required this.password,
    required this.serverKey,
    this.username,
    this.firstName,
    this.lastName,
    this.phone,
    this.confirmPassword,
    this.gender,
  });

  Map<String, dynamic> toJson() {
    return {
      "server_key": serverKey,
      "email": email,
      "password": password,
      if (username != null) "username": username,
      if (firstName != null) "first_name": firstName,
      if (lastName != null) "last_name": lastName,
      if (phone != null) "phone_num": phone,
      if (confirmPassword != null) "confirm_password": confirmPassword,
      if (gender != null) "gender": gender,
    };
  }
}
