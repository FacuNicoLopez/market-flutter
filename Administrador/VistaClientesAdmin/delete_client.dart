import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_csharp3/Clientes/BLoCCliente/client_event.dart';
import 'package:flutter_csharp3/Clientes/BLoCCliente/client_model.dart';
import 'package:flutter_csharp3/Clientes/BLoCCliente/cliente_bloc.dart';

void showDeleteDialog(BuildContext context, Cliente cliente) {
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
                'Confirmar',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Estas seguro que desea eliminar este Cliente?',
                textAlign: TextAlign.center,
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
                      if (cliente.idCliente != null) {
                        BlocProvider.of<ClienteBloc>(context)
                            .add(DeleteCliente(cliente.idCliente!));
                        Navigator.of(context).pop();

                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('Eliminacion en proceso..'),
                          duration: Duration(seconds: 2),
                        ));
                      }
                    },
                    child: const Text('Eliminar',
                        style: TextStyle(color: Colors.red)),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
