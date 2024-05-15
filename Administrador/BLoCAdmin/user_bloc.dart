import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_csharp3/Administrador/BLoCAdmin/user_event.dart';
import 'package:flutter_csharp3/Administrador/BLoCAdmin/user_state.dart';
import 'package:flutter_csharp3/Administrador/BLoCAdmin/user_model.dart';
import 'package:flutter_csharp3/config.dart';
import 'package:http/http.dart' as http;

class UsuarioBloc extends Bloc<UsuarioEvent, UsuarioState> {
  Usuario? usuarioActual;
  final url1 = direccionUrl;

  Future<Usuario> _login(String email, String password) async {
    try {
      var url4 = Uri.parse('$url1/login');
      final response = await http.post(url4,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "email": email,
            "password": password,
          }));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final userId = data['userId'] as int;
        final token = data['token'] as String?;
        final email = data['email'];
        final nameUser = data['nameUser'] as String?;
        return Usuario(
            userId: userId, token: token, email: email, nameUser: nameUser);
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
