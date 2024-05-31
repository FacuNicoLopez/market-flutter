import 'dart:convert';

Billetera billeteraFromJson(String str) => Billetera.fromJson(json.decode(str));

String billeteraToJson(Billetera data) => json.encode(data.toJson());

class Billetera {
  int clienteId;
  int monto;
  String tipoTransaccion;

  Billetera({
    required this.clienteId,
    required this.monto,
    required this.tipoTransaccion,
  });

  factory Billetera.fromJson(Map<String, dynamic> json) => Billetera(
        clienteId: json["clienteId"],
        monto: json["monto"],
        tipoTransaccion: json["tipoTransaccion"],
      );

  Map<String, dynamic> toJson() => {
        "clienteId": clienteId,
        "monto": monto,
        "tipoTransaccion": tipoTransaccion,
      };
}
