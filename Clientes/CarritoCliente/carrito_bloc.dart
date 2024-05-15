import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_csharp3/Clientes/BLoCCliente/cliente_bloc.dart';
import 'package:flutter_csharp3/Clientes/CarritoCliente/carrito_event.dart';
import 'package:flutter_csharp3/Clientes/CarritoCliente/carrito_model.dart';
import 'package:flutter_csharp3/Clientes/CarritoCliente/carrito_state.dart';
import 'package:flutter_csharp3/config.dart';
import 'package:http/http.dart' as http;

class CarritoBloc extends Bloc<CarritoEvent, CarritoState> {
  final LoginClientBloc loginClientBloc;
  Carrito? carrito;

  final url5 = direccionUrl;

  CarritoBloc(this.loginClientBloc) : super(CarritoLoading()) {
    on<LoadCartItems>(_onLoadCartItems);
    on<AddCarrito>(_onAddCarrito);
    on<RemoveItemFromCart>(_onRemoveItemFromCart);
    on<UpdateCartItem>(_onUpdateCartItem);
    on<ClearCarrito>(_onClearCarrito);
  }

  Future<void> _onLoadCartItems(
      LoadCartItems event, Emitter<CarritoState> emit) async {
    if (loginClientBloc.clienteActual == null ||
        loginClientBloc.clienteActual!.idCliente == null) {
      emit(CarritoError(
          'Cliente no cargado en LoginClientBloc o idCliente es nulo'));
      return;
    }

    emit(CarritoLoading());
    final response = await http.get(Uri.parse(
        '$url5/cliente/carrito/${loginClientBloc.clienteActual!.idCliente}'));
    if (response.statusCode != 200) {
      emit(CarritoError('Error al cargar articulos del carrito'));
      return;
    }

    try {
      final List<dynamic> carritoJson = json.decode(response.body);
      final List<Carrito> carritos = carritoJson.map((json) {
        var carrito = Carrito.fromJson(json);
        return carrito;
      }).toList();
      final Map<int, Carrito> consolidatedCarritos = {};
      for (Carrito c in carritos) {
        if (consolidatedCarritos.containsKey(c.articuloCarrito)) {
          consolidatedCarritos[c.articuloCarrito]!.cantidad += c.cantidad;
        } else {
          consolidatedCarritos[c.articuloCarrito] = c;
        }
      }

      emit(CarritoLoaded(consolidatedCarritos.values.toList()));
    } catch (e) {
      emit(CarritoError(
          'Error al procesar los datos del carrito: ${e.toString()}'));
    }
  }

  void _onAddCarrito(AddCarrito event, Emitter<CarritoState> emit) async {
    final jsonCarrito = jsonEncode(event.carrito);

    try {
      final response = await http.post(
        Uri.parse('$url5/cliente/carrito/add'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonCarrito,
      );
      if (response.statusCode == 201) {
        final nuevoCarrito = Carrito.fromJson(jsonDecode(response.body));
        add(LoadCartItems());
        if (state is CarritoLoaded) {
          final currentState = state as CarritoLoaded;
          emit(CarritoLoaded([...currentState.carritos, nuevoCarrito]));
        }
      } else {
        emit(CarritoError('Error al agregar Carrito: ${response.body}'));
      }
    } catch (e) {
      emit(CarritoError('Error al agregar Carrito: ${e.toString()}'));
    }
  }

  void _onRemoveItemFromCart(
      RemoveItemFromCart event, Emitter<CarritoState> emit) async {
    if (state is CarritoLoaded) {
      final currentState = state as CarritoLoaded;
      try {
        final response = await http.delete(
            Uri.parse('$url5/cliente/carrito/remove/${event.carritoId}'));

        if (response.statusCode == 204) {
          final updatedItems = currentState.carritos
              .where((item) => item.id != event.carritoId)
              .toList();
          emit(CarritoLoaded(updatedItems));
        } else {
          emit(CarritoError('Error al eliminar el carrito'));
        }
      } catch (e) {
        emit(
            CarritoError('Error al conectar con el servidor: ${e.toString()}'));
      }
    }
  }

  void _onUpdateCartItem(
      UpdateCartItem event, Emitter<CarritoState> emit) async {
    if (state is CarritoLoaded) {
      try {
        final currentState = state as CarritoLoaded;
        final response = await http.post(
          Uri.parse('$url5/cliente/carrito/update'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            'ClienteCarrito': loginClientBloc.clienteActual!.idCliente,
            'ArticuloCarrito': event.articuloId,
            'Cantidad': event.nuevaCantidad,
          }),
        );
        if (response.statusCode == 204) {
          var updateItems = currentState.carritos.map((item) {
            if (item.articuloCarrito == event.articuloId) {
              return item.copyWith(cantidad: event.nuevaCantidad);
            }
            return item;
          }).toList();
          emit(CarritoLoaded(List.from(updateItems)));
        } else {
          emit(CarritoError('Error al actualizar el carrito'));
        }
      } catch (e) {
        emit(
            CarritoError('Error al conectar con el servidor: ${e.toString()}'));
      }
    }
  }

  void _onClearCarrito(ClearCarrito event, Emitter<CarritoState> emit) async {
    if (loginClientBloc.clienteActual == null ||
        loginClientBloc.clienteActual!.idCliente == null) {
      emit(CarritoError('Identificacion del cliente no disponible'));
      return;
    }
    try {
      final response = await http.delete(
        Uri.parse(
            '$url5/cliente/carrito/clear/${loginClientBloc.clienteActual!.idCliente}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body:
            jsonEncode({'clienteId': loginClientBloc.clienteActual!.idCliente}),
      );

      if (response.statusCode == 204) {
        emit(CarritoLoaded([]));
      } else {
        emit(CarritoError('Error al limpiar el carrito: ${response.body}'));
      }
    } catch (e) {
      emit(CarritoError('Error al conectar con el servidor: ${e.toString()}'));
    }
  }
}
