import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_csharp3/Clientes/BLoCCliente/client_event.dart';
import 'package:flutter_csharp3/Clientes/BLoCCliente/client_model.dart';
import 'package:flutter_csharp3/Clientes/BLoCCliente/cliente_bloc.dart';

void showAddDialog(BuildContext context) {
  final emailController = TextEditingController();
  final claveController = TextEditingController();
  final nombreController = TextEditingController();
  final apellidoController = TextEditingController();
  showDialog(
      context: context,
      barrierColor: Colors.black54,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.85),
              borderRadius: BorderRadius.circular(15),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                  ),
                  TextFormField(
                    controller: claveController,
                    decoration: const InputDecoration(labelText: 'Contraseña'),
                  ),
                  TextFormField(
                    controller: nombreController,
                    decoration: const InputDecoration(labelText: 'Nombre'),
                  ),
                  TextFormField(
                    controller: apellidoController,
                    decoration: const InputDecoration(labelText: 'Apellido'),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Cancelar'),
                      ),
                      TextButton(
                        onPressed: () {
                          final nuevoCliente = Cliente(
                            token: '',
                            emailCliente: emailController.text,
                            claveCliente: claveController.text,
                            nombreCliente: nombreController.text,
                            apellidoCliente: apellidoController.text,
                          );
                          BlocProvider.of<ClienteBloc>(context)
                              .add(AddCliente(nuevoCliente));
                          Navigator.of(context).pop();
                        },
                        child: const Text('Guardar',
                            style: TextStyle(color: Colors.green)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      });
}
