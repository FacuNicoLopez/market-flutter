import 'package:flutter_csharp3/Clientes/CarritoCliente/carrito_model.dart';

abstract class CarritoEvent {}

class LoadCartItems extends CarritoEvent {}

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
