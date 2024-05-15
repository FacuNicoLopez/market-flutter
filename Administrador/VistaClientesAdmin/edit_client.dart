import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_csharp3/Clientes/BLoCCliente/client_event.dart';
import 'package:flutter_csharp3/Clientes/BLoCCliente/client_model.dart';
import 'package:flutter_csharp3/Clientes/BLoCCliente/cliente_bloc.dart';

void showEditDialog(BuildContext context, Cliente cliente) {
  final nombreController = TextEditingController(text: cliente.nombreCliente);
  final apellidoController =
      TextEditingController(text: cliente.apellidoCliente);

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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Editar Cliente',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                TextField(
                  controller: nombreController,
                  decoration: const InputDecoration(labelText: 'Nombre'),
                ),
                TextField(
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
                        final editedCliente = Cliente(
                          idCliente: cliente.idCliente,
                          token: cliente.token,
                          emailCliente: cliente.emailCliente,
                          claveCliente: cliente.claveCliente,
                          nombreCliente: nombreController.text,
                          apellidoCliente: apellidoController.text,
                        );
                        BlocProvider.of<ClienteBloc>(context)
                            .add(EditCliente(editedCliente));
                        Navigator.of(context).pop();
                      },
                      child: const Text('Guardar Cambios',
                          style: TextStyle(color: Colors.green)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      });
}
