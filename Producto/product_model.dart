import 'dart:convert';

import 'package:flutter_csharp3/Clientes/CarritoCliente/carrito_model.dart';

List<Articulo> articuloFromJson(String str) =>
    List<Articulo>.from(json.decode(str).map((x) => Articulo.fromJson(x)));

String articuloToJson(List<Articulo> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Articulo {
  int? id;
  String nombreArticulo;
  String talle;
  double precio;
  int stock;
  dynamic imagen;
  List<Carrito>? carritos;

  Articulo({
    this.id,
    required this.nombreArticulo,
    required this.talle,
    required this.precio,
    required this.stock,
    this.imagen,
    this.carritos,
  });

  Articulo copyWith(
      {int? id,
      String? nombreArticulo,
      String? talle,
      double? precio,
      int? stock,
      dynamic imagen,
      List<Carrito>? carritos}) {
    return Articulo(
        id: id ?? this.id,
        nombreArticulo: nombreArticulo ?? this.nombreArticulo,
        talle: talle ?? this.talle,
        precio: precio ?? this.precio,
        stock: stock ?? this.stock,
        imagen: imagen ?? this.imagen,
        carritos: carritos ?? this.carritos);
  }

  factory Articulo.fromJson(Map<String, dynamic> json) {
    return Articulo(
      id: json['id'] as int,
      nombreArticulo: json['nombreArticulo'] as String,
      talle: json['talle'] as String,
      precio: json['precio'] as double,
      stock: json['stock'] as int,
      imagen: json['imagen'] as String,
      carritos: (json['carritos'] as List<dynamic>?)
              ?.map((e) => Carrito.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      "nombreArticulo": nombreArticulo,
      "talle": talle,
      "precio": precio,
      "stock": stock,
      "imagen": imagen,
    };
    if (id != null) {
      data["id"] = id;
    }
    return data;
  }
}
