import 'dart:convert';

List<Cliente> clienteFromJson(String str) =>
    List<Cliente>.from(json.decode(str).map((x) => Cliente.fromJson(x)));

String clienteToJson(List<Cliente> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Cliente {
  int? idCliente;
  String? token;
  String emailCliente;
  String? claveCliente;
  String? nombreCliente;
  String? apellidoCliente;

  Cliente({
    this.idCliente,
    this.token,
    required this.emailCliente,
    this.claveCliente,
    this.nombreCliente,
    this.apellidoCliente,
  });

  Cliente copyWith({
    int? idCliente,
    String? token,
    String? emailCliente,
    String? claveCliente,
    String? nombreCliente,
    String? apellidoCliente,
  }) {
    return Cliente(
      idCliente: idCliente ?? this.idCliente,
      token: token ?? this.token,
      emailCliente: emailCliente ?? this.emailCliente,
      claveCliente: claveCliente ?? this.claveCliente,
      nombreCliente: nombreCliente ?? this.nombreCliente,
      apellidoCliente: apellidoCliente ?? this.apellidoCliente,
    );
  }

  factory Cliente.fromJson(Map<String, dynamic> json) => Cliente(
        idCliente: json['clienteId'] ?? json['idCliente'] as int?,
        token: json['token'] as String?,
        emailCliente: json['emailCliente'] as String,
        claveCliente: json['claveCliente'] as String?,
        nombreCliente: json['nombreCliente'] as String?,
        apellidoCliente: json['apellidoCliente'] as String?,
      );

  Map<String, dynamic> toJson() => {
        "idCliente": idCliente,
        "token": token,
        "emailCliente": emailCliente,
        "claveCliente": claveCliente,
        "nombreCliente": nombreCliente,
        "apellidocliente": apellidoCliente,
      };
}
