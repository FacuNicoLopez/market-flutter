import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_csharp3/Clientes/BLoCCliente/client_model.dart';
import 'package:flutter_csharp3/Clientes/BarClientes/button_logout.dart';
import 'package:flutter_csharp3/Clientes/BarClientes/custom_drawer.dart';
import 'package:flutter_csharp3/Clientes/CarritoCliente/carrito_bloc.dart';
import 'package:flutter_csharp3/Clientes/CarritoCliente/carrito_state.dart';
import 'package:go_router/go_router.dart';

class CommonScaffold extends StatelessWidget {
  final Widget body;
  final Cliente? cliente;
  final String title;
  final FloatingActionButton? floatingActionButton;

  const CommonScaffold({
    super.key,
    required this.body,
    this.cliente,
    required this.title,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          BlocBuilder<CarritoBloc, CarritoState>(
            builder: (context, state) {
              bool hasItems =
                  state is CarritoLoaded && state.carritos.isNotEmpty;
              return IconButton(
                icon: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    const Icon(Icons.shopping_cart),
                    if (hasItems)
                      CircleAvatar(
                        radius: 6,
                        backgroundColor: Colors.red,
                        child: Text(
                          state.carritos.length.toString(),
                          style: const TextStyle(
                              fontSize: 6,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      )
                  ],
                ),
                onPressed: () {
                  context.go('/carrito');
                },
              );
            },
          ),
          const LogoutButton()
        ],
      ),
      drawer:
          cliente != null ? CustomDrawer(cliente: cliente!) : const SizedBox(),
      body: body,
      floatingActionButton: floatingActionButton,
    );
  }
}
