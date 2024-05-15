abstract class UsuarioEvent {}

class CargarUsuario extends UsuarioEvent {}

class UsuarioLoginEvent extends UsuarioEvent {
  final String email;
  final String password;

  UsuarioLoginEvent(this.email, this.password);
}
