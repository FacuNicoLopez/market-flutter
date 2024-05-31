import 'package:flutter_csharp3/Administrador/BLoCAdmin/user_model.dart';

abstract class UsuarioEvent {}

class CargarUsuario extends UsuarioEvent {}

class UsuarioLoginEvent extends UsuarioEvent {
  final String email;
  final String password;

  UsuarioLoginEvent(this.email, this.password);
}

class AddUser extends UsuarioEvent {
  final Usuario usuario;

  AddUser(this.usuario);
}

class DeleteUser extends UsuarioEvent {
  final int usuarioId;

  DeleteUser(this.usuarioId);
}
