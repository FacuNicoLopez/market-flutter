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
  double? saldo;

  Cliente({
    this.idCliente,
    this.token,
    required this.emailCliente,
    this.claveCliente,
    this.nombreCliente,
    this.apellidoCliente,
    this.saldo,
  });

  Cliente copyWith({
    int? idCliente,
    String? token,
    String? emailCliente,
    String? claveCliente,
    String? nombreCliente,
    String? apellidoCliente,
    double? saldo,
  }) {
    return Cliente(
        idCliente: idCliente ?? this.idCliente,
        token: token ?? this.token,
        emailCliente: emailCliente ?? this.emailCliente,
        claveCliente: claveCliente ?? this.claveCliente,
        nombreCliente: nombreCliente ?? this.nombreCliente,
        apellidoCliente: apellidoCliente ?? this.apellidoCliente,
        saldo: saldo ?? this.saldo);
  }

  factory Cliente.fromJson(Map<String, dynamic> json) => Cliente(
        idCliente: json['clienteId'] ?? json['idCliente'] as int?,
        token: json['token'] as String?,
        emailCliente: json['emailCliente'] as String,
        claveCliente: json['claveCliente'] as String?,
        nombreCliente: json['nombreCliente'] as String?,
        apellidoCliente: json['apellidoCliente'] as String?,
        saldo: (json['saldoCliente'] as num?)?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "idCliente": idCliente,
        "token": token,
        "emailCliente": emailCliente,
        "claveCliente": claveCliente,
        "nombreCliente": nombreCliente,
        "apellidocliente": apellidoCliente,
        "saldoCliente": saldo,
      };
}
