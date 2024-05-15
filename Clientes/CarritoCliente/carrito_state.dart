import 'package:flutter_csharp3/Clientes/CarritoCliente/carrito_model.dart';

abstract class CarritoState {}

class CarritoLoading extends CarritoState {}

class CarritoLoaded extends CarritoState {
  final List<Carrito> carritos;

  CarritoLoaded(this.carritos);

  CarritoLoaded copyWith({
    List<Carrito>? carritos,
  }) {
    return CarritoLoaded(carritos ?? this.carritos);
  }
}

class CarritoError extends CarritoState {
  final String message;

  CarritoError(this.message);
}
