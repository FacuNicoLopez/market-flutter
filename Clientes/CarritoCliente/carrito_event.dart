import 'package:flutter_csharp3/Clientes/CarritoCliente/carrito_model.dart';

abstract class CarritoEvent {}

class LoadCartItems extends CarritoEvent {}

// class AddItemToCart extends CarritoEvent {
//   final int clienteId;
//   final int articuloId;
//   final int cantidad;
//   final String nombreArticulo;
//   final double precio;
//   final int stock;
//   final String imagenUrl;

//   AddItemToCart(
//       {required this.clienteId,
//       required this.articuloId,
//       required this.cantidad,
//       required this.nombreArticulo,
//       required this.precio,
//       required this.stock,
//       required this.imagenUrl});
// }

class RemoveItemFromCart extends CarritoEvent {
  final int carritoId;

  RemoveItemFromCart(this.carritoId);
}

class UpdateCartItem extends CarritoEvent {
  final int articuloId;
  final int nuevaCantidad;

  UpdateCartItem({required this.articuloId, required this.nuevaCantidad});
}

class AddCarrito extends CarritoEvent {
  final Carrito carrito;
  AddCarrito(this.carrito);
}

class ClearCarrito extends CarritoEvent {}
