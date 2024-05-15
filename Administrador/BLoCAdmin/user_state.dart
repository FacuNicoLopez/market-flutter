import 'package:flutter_csharp3/Administrador/BLoCAdmin/user_model.dart';

abstract class UsuarioState {}

class UsuarioInitial extends UsuarioState {}

class UsuarioLoading extends UsuarioState {}

class UsuarioLoaded extends UsuarioState {
  final Usuario usuario;

  UsuarioLoaded(this.usuario);
}

class UsuarioError extends UsuarioState {
  final String message;

  UsuarioError(this.message);
}
