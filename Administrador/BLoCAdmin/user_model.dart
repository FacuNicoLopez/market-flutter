import 'dart:convert';

List<Usuario> usuarioFromJson(String str) =>
    List<Usuario>.from(json.decode(str).map((x) => Usuario.fromJson(x)));

String usuarioToJson(List<Usuario> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Usuario {
  int? userId;
  String? token;
  String email;
  String? password;
  String? nameUser;
  String? apellido;
  bool? isAdmin;

  Usuario({
    this.userId,
    required this.token,
    required this.email,
    this.password,
    this.nameUser = '',
    this.apellido,
    this.isAdmin,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        userId: json["userId"],
        token: json['token'] as String?,
        email: json["email"] as String,
        password: json["password"] as String?,
        nameUser: json['nameUser'] as String?,
        apellido: json['apellido'] as String?,
        isAdmin: json["isAdmin"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "token": token,
        "email": email,
        "password": password,
        "nameUser": nameUser,
        "apellido": apellido,
        "isAdmin": isAdmin,
      };

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'token': token,
      'email': email,
      'nameUser': nameUser,
      'apellido': apellido,
      'isAdmin': isAdmin,
    };
  }

  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(
      userId: map['userId'] as int,
      token: map['token'] as String?,
      email: map['email'] as String,
      nameUser: map['nameUser'] as String,
      apellido: map['apellido'] as String,
      isAdmin: map['isAdmin'] as bool?,
    );
  }
}
