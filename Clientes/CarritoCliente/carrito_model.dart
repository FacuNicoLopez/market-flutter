import 'dart:convert';

List<Carrito> carritoFromJson(String str) =>
    List<Carrito>.from(json.decode(str).map((x) => Carrito.fromJson(x)));

String carritoToJson(List<Carrito> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Carrito {
  int id;
  int clienteCarrito;
  int articuloCarrito;
  int cantidad;
  String? articuloNombre;
  double? precio;
  int? stock;
  String? imagenUrl;

  Carrito(
      {required this.id,
      required this.clienteCarrito,
      required this.articuloCarrito,
      required this.cantidad,
      this.articuloNombre,
      this.precio,
      this.stock,
      this.imagenUrl});

  Carrito copyWith({
    int? idCarrito,
    int? clienteCarrito,
    int? articuloCarrito,
    int? cantidad,
    String? articuloNombre,
    double? precio,
    int? stock,
    String? imagenUrl,
  }) {
    return Carrito(
        id: idCarrito ?? id,
        clienteCarrito: clienteCarrito ?? this.clienteCarrito,
        articuloCarrito: articuloCarrito ?? this.articuloCarrito,
        cantidad: cantidad ?? this.cantidad,
        articuloNombre: articuloNombre ?? this.articuloNombre,
        precio: precio ?? this.precio,
        stock: stock ?? this.stock,
        imagenUrl: imagenUrl ?? this.imagenUrl);
  }

  factory Carrito.fromJson(Map<String, dynamic> json) => Carrito(
        id: json["id"] as int? ?? 0,
        clienteCarrito: json["clienteCarrito"] as int? ?? 0,
        articuloCarrito: json["articuloCarrito"] as int? ?? 0,
        cantidad: json["cantidad"] as int? ?? 0,
        articuloNombre: json["articuloNombre"] as String?,
        precio: (json["precio"] != null) ? json["precio"].toDouble() : null,
        stock: json["stock"] as int? ?? 0,
        imagenUrl: json["imagenUrl"] as String?,
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'clienteCarrito': clienteCarrito,
      'articuloCarrito': articuloCarrito,
      'cantidad': cantidad,
      'articuloNombre': articuloNombre,
      'precio': precio,
      'stock': stock,
      'imagenUrl': imagenUrl,
    };
  }
}
