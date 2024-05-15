import 'package:flutter_csharp3/Clientes/BLoCCliente/client_model.dart';

abstract class ClienteEvent {}

class LoadClientes extends ClienteEvent {}

class ClientLoginEvent extends ClienteEvent {
  final String email;
  final String password;

  ClientLoginEvent(this.email, this.password);
}

class DeleteCliente extends ClienteEvent {
  final int clienteId;
  DeleteCliente(this.clienteId);
}

class EditCliente extends ClienteEvent {
  final Cliente cliente;
  EditCliente(this.cliente);
}

class AddCliente extends ClienteEvent {
  final Cliente cliente;
  AddCliente(this.cliente);
}
