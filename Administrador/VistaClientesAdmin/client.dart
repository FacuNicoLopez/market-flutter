import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_csharp3/Administrador/VistaClientesAdmin/add_cliente.dart';
import 'package:flutter_csharp3/Administrador/VistaClientesAdmin/delete_client.dart';
import 'package:flutter_csharp3/Administrador/VistaClientesAdmin/edit_client.dart';
import 'package:flutter_csharp3/Clientes/BLoCCliente/cliente_bloc.dart';
import 'package:flutter_csharp3/Administrador/BLoCAdmin/user_bloc.dart';
import 'package:flutter_csharp3/Clientes/BLoCCliente/client_state.dart';
import 'package:flutter_csharp3/Administrador/BLoCAdmin/user_state.dart';
import 'package:flutter_csharp3/Administrador/BarAdmin/bar_admin.dart';

class ClientUser extends StatelessWidget {
  const ClientUser({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsuarioBloc, UsuarioState>(
      builder: (context, usuarioState) {
        if (usuarioState is UsuarioLoaded) {
          final usuario = usuarioState.usuario;
          return CommonScaffold(
            usuario: usuario,
            title: 'Ajuste Clientes',
            body: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color.fromRGBO(225, 231, 233, 1),
                  Color.fromRGBO(70, 169, 178, 1)
                ]),
              ),
              child: BlocBuilder<ClienteBloc, ClienteState>(
                builder: (context, state) {
                  if (state is ClientesLoading) {
                    return const CircularProgressIndicator();
                  } else if (state is ClientesLoaded) {
                    return ListView.separated(
                        itemCount: state.clientes.length,
                        separatorBuilder: (_, __) =>
                            const Divider(color: Color.fromARGB(255, 0, 0, 0)),
                        itemBuilder: (context, index) {
                          final cliente = state.clientes[index];
                          return ListTile(
                            title: Text(
                              '${cliente.nombreCliente} ${cliente.apellidoCliente}',
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0)),
                            ),
                            leading: const Icon(Icons.person,
                                color: Color.fromARGB(255, 0, 0, 0)),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                iconButtonWithShadow(Icons.edit, Colors.green,
                                    () => showEditDialog(context, cliente)),
                                const SizedBox(width: 16),
                                iconButtonWithShadow(Icons.delete, Colors.red,
                                    () => showDeleteDialog(context, cliente))
                              ],
                            ),
                          );
                        });
                  } else if (state is ClientesError) {
                    return Text(state.message,
                        style: const TextStyle(color: Colors.white));
                  } else {
                    return const Text('Unknown state',
                        style: TextStyle(color: Colors.white));
                  }
                },
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => showAddDialog(context),
              tooltip: 'Agregar Cliente',
              backgroundColor: const Color.fromARGB(255, 71, 232, 77),
              child: const Icon(Icons.add),
            ),
          );
        } else {
          return const Scaffold(
            body: Center(
              child: Text('Usuario no disponible',
                  style: TextStyle(color: Colors.white)),
            ),
          );
        }
      },
    );
  }

  Widget iconButtonWithShadow(
      IconData icon, Color color, VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 3,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(icon, color: color),
        onPressed: onPressed,
      ),
    );
  }
}
