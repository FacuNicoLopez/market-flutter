import 'dart:convert';

import 'package:flutter_csharp3/Administrador/screen_view_admin.dart';
import 'package:http/http.dart' as http;

class UsuarioBloc extends Bloc<UsuarioEvent, UsuarioState> {
  Usuario? usuarioActual;
  final url1 = direccionUrl;

  Future<Usuario> _login(String email, String password) async {
    try {
      var url4 = Uri.parse('$url1/usuario/login');
      final response = await http.post(url4,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "email": email,
            "password": password,
            "nameUser": "",
            "apellido": ""
          }));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final userId = data['userId'] as int?;
        final token = data['token'] as String?;
        final email = data['email'];
        final nameUser = data['nameUser'] as String?;
        final apellido = data['apellido'] as String?;

        return Usuario(
            userId: userId,
            token: token,
            email: email,
            nameUser: nameUser,
            apellido: apellido);
      } else {
        throw Exception('Error al cargar usuario');
      }
    } catch (e) {
      throw Exception('Error al cargar usuario $e');
    }
  }

  UsuarioBloc() : super(UsuarioInitial()) {
    on<UsuarioLoginEvent>((event, emit) async {
      emit(UsuarioLoading());
      try {
        final usuario = await _login(event.email, event.password);
        usuarioActual = usuario;
        emit(UsuarioLoaded(usuario));
      } catch (e) {
        emit(UsuarioError('Error durante el inicio de sesión ${e.toString()}'));
      }
    });
  }
}

//ADD DELET Y EDIT ADMIN
class UsuarioAddDeleteBloc extends Bloc<UsuarioEvent, UsuarioState> {
  UsuarioAddDeleteBloc() : super(UsuarioLoading()) {
    on<AddUser>(_onAddUser);
    // on<DeleteUser>(_onDeleteUser);
  }

  final url5 = direccionUrl;

  void _onAddUser(AddUser event, Emitter<UsuarioState> emit) async {
    final jsonUser = jsonEncode(event.usuario.toJson());

    try {
      final response = await http.post(Uri.parse('$url5/usuario/register'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: jsonUser);

      if (response.statusCode == 201) {
        final nuevoUsuario = Usuario.fromJson(jsonDecode(response.body));
        if (state is UsuariosLoaded) {
          final currentState = state as UsuariosLoaded;
          emit(UsuariosLoaded([...currentState.usuarios, nuevoUsuario]));
        }
      } else {
        emit(UsuarioError(
            'Error al agregar un nuevo usuario: ${response.body}'));
      }
    } catch (e) {
      emit(UsuarioError('Error del servidor: ${e.toString()}'));
    }
  }
}
