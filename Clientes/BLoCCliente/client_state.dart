import 'package:flutter_csharp3/Clientes/BLoCCliente/client_model.dart';

abstract class ClienteState {}

class ClientInitial extends ClienteState {}

class ClientesLoading extends ClienteState {}

class ClientesLoaded extends ClienteState {
  final List<Cliente> clientes;
  ClientesLoaded(this.clientes);
}

class ClienteCargado extends ClienteState {
  final Cliente cliente;
  ClienteCargado(this.cliente);
}

class ClientesError extends ClienteState {
  final String message;
  ClientesError(this.message);
}

class ClienteDeleted extends ClienteState {}

class ClienteEdited extends ClienteState {}
