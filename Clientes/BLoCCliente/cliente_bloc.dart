import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_csharp3/Clientes/BLoCCliente/client_event.dart';
import 'package:flutter_csharp3/Clientes/BLoCCliente/client_model.dart';
import 'package:flutter_csharp3/Clientes/BLoCCliente/client_state.dart';
import 'package:flutter_csharp3/config.dart';
import 'package:http/http.dart' as http;

//MANEJO DE INICIO DE SESION DE CLIENTES
class LoginClientBloc extends Bloc<ClienteEvent, ClienteState> {
  Cliente? clienteActual;

  final url2 = direccionUrl;

  // Future<Cliente> _loginCliente(String email, String password) async {
  //   try {
  //     var url5 = Uri.parse('$url2/cliente/login');
  //     final response = await http.post(url5,
  //         headers: {"Content-Type": "application/json"},
  //         body: jsonEncode({
  //           "emailCliente": email,
  //           "claveCliente": password,
  //         }));
  //     if (response.statusCode == 200) {
  //       if (response.statusCode != 200) {
  //         throw Exception('Failed to load user: ${response.body}');
  //       }

  //       final data = jsonDecode(response.body);
  //       final idCliente = data['idCliente'] as int?;
  //       final token = data['token'] as String?;
  //       final emailCliente = data['emailCliente'] as String;
  //       final nombreCliente = data['nombreCliente'] as String?;
  //       return Cliente(
  //           idCliente: idCliente,
  //           token: token,
  //           emailCliente: emailCliente,
  //           nombreCliente: nombreCliente);
  //     } else {
  //       throw Exception('Error al cargar usuario');
  //     }
  //   } catch (e) {
  //     throw Exception('Error al cargar usuario ${e.toString()}');
  //   }
  // }

  LoginClientBloc() : super(ClientInitial()) {
    on<ClientLoginEvent>((event, emit) async {
      emit(ClientesLoading());
      try {
        final response = await http.post(Uri.parse('$url2/cliente/login'),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode(
                {"emailCliente": event.email, "claveCliente": event.password}));

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          final cliente = Cliente.fromJson(data);

          if (cliente.idCliente != null) {
            clienteActual = cliente;
            emit(ClienteCargado(cliente));
          } else {
            emit(ClientesError('ID del cliente no encontrado'));
          }
        } else {
          emit(ClientesError('Error al cargar usuario: ${response.body}'));
        }
      } catch (e) {
        emit(ClientesError(
            'Error durante el inicio de sesión: ${e.toString()}'));
      }
    });
  }
}

//ABM PARA CLIENTES
class ClienteBloc extends Bloc<ClienteEvent, ClienteState> {
  final url3 = direccionUrl;

  ClienteBloc() : super(ClientesLoading()) {
    on<LoadClientes>(_onLoadClientes);
    on<DeleteCliente>(_onDeleteCliente);
    on<EditCliente>(_onEditCliente);
    on<AddCliente>(_onAddCliente);
  }

  void _onLoadClientes(LoadClientes event, Emitter<ClienteState> emit) async {
    emit(ClientesLoading());
    try {
      final response = await http.get(Uri.parse('$url3/cliente'));
      if (response.statusCode == 200) {
        final List<dynamic> clienteJson = json.decode(response.body);
        final clientes =
            clienteJson.map((json) => Cliente.fromJson(json)).toList();
        emit(ClientesLoaded(clientes));
      } else {
        emit(ClientesError('Error al cargar Clientes'));
      }
    } catch (e) {
      emit(ClientesError('Error al cargar Clientes: ${e.toString()}'));
    }
  }

  void _onDeleteCliente(DeleteCliente event, Emitter<ClienteState> emit) async {
    try {
      final response = await http.delete(
          Uri.parse('$url3/cliente/${event.clienteId}/delete'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });
      if (response.statusCode == 204) {
        emit(ClienteDeleted());
        add(LoadClientes());
      } else if (response.statusCode == 400) {
        emit(ClientesError(
            'El cliente no puede ser eliminado porque está en uno o más carritos.'));
        add(LoadClientes());
      }
      {
        emit(ClientesError('Error al eliminar Cliente'));
      }
    } catch (e) {
      emit(ClientesError('Error al eliminar Cliente: ${e.toString()}'));
    }
  }

  void _onEditCliente(EditCliente event, Emitter<ClienteState> emit) async {
    try {
      final response = await http.put(
        Uri.parse('$url3/cliente/${event.cliente.idCliente}/edit'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(event.cliente.toJson()),
      );
      if (response.statusCode == 204) {
        emit(ClienteEdited());
        add(LoadClientes());
      } else {
        emit(ClientesError('Error al editar Cliente'));
      }
    } catch (e) {
      emit(ClientesError('Error al editar Cliente: ${e.toString()}'));
    }
  }

  void _onAddCliente(AddCliente event, Emitter<ClienteState> emit) async {
    final jsonCliente = jsonEncode(event.cliente.toJson());

    try {
      final response = await http.post(
        Uri.parse('$url3/cliente/add'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonCliente,
      );

      if (response.statusCode == 201) {
        final nuevoCliente = Cliente.fromJson(jsonDecode(response.body));
        if (state is ClientesLoaded) {
          final currentState = state as ClientesLoaded;
          emit(ClientesLoaded([...currentState.clientes, nuevoCliente]));
        }
      } else {
        emit(ClientesError('Error al agregar Cliente: ${response.body}'));
      }
    } catch (e) {
      emit(ClientesError('Error al agregar Cliente: ${e.toString()}'));
    }
  }
}
