import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_csharp3/Clientes/BLoCCliente/client_state.dart';
import 'package:flutter_csharp3/Clientes/BLoCCliente/cliente_bloc.dart';
import 'package:flutter_csharp3/Clientes/CarritoCliente/carrito_bloc.dart';
import 'package:flutter_csharp3/Clientes/CarritoCliente/carrito_event.dart';
import 'package:flutter_csharp3/Clientes/CarritoCliente/carrito_model.dart';
import 'package:flutter_csharp3/Clientes/BarClientes/bar_client.dart';
import 'package:flutter_csharp3/Producto/product_bloc.dart';
import 'package:flutter_csharp3/Producto/product_event.dart';
import 'package:flutter_csharp3/Producto/product_state.dart';

class BuzoCliente extends StatelessWidget {
  const BuzoCliente({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ArticuloBloc>().add(LoadArticulos());

    return BlocBuilder<LoginClientBloc, ClienteState>(
        builder: (context, clienteState) {
      if (clienteState is ClienteCargado) {
        final cliente = clienteState.cliente;
        return CommonScaffold(
            cliente: cliente,
            title: 'Productos',
            body: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                Color.fromRGBO(70, 169, 178, 1),
                Color.fromRGBO(255, 231, 233, 1)
              ])),
              child: BlocBuilder<ArticuloBloc, ArticuloState>(
                builder: (context, state) {
                  if (state is ArticulosLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ArticulosLoaded) {
                    var buzos = state.articulos
                        .where((art) =>
                            art.nombreArticulo.toLowerCase().contains('buzo'))
                        .toList();
                    return ListView.builder(
                      itemCount: buzos.length,
                      itemBuilder: (context, index) {
                        return Container(
                            height: 440,
                            margin: const EdgeInsets.all(22),
                            decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                  blurRadius: 10,
                                  spreadRadius: 1,
                                ),
                              ],
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(children: [
                              Padding(
                                padding: const EdgeInsets.all(12),
                                child: Text(
                                  buzos[index].nombreArticulo,
                                  style: const TextStyle(
                                    fontSize: 22,
                                    color: Color.fromARGB(255, 29, 35, 40),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                    bottom: Radius.circular(10)),
                                child: Image.network(
                                  buzos[index].imagen,
                                  width: double.infinity,
                                  height: 300,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Precio: ${buzos[index].precio}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Stock disponible: ${buzos[index].stock}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ]),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Container(
                                      color: Colors.white.withOpacity(0.5),
                                      child: ElevatedButton.icon(
                                        icon: const Icon(
                                            Icons.add_shopping_cart,
                                            color: Color.fromARGB(
                                                255, 255, 255, 255)),
                                        label: const Text(
                                          'Agregar al carrito',
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255)),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                            foregroundColor: Colors.white,
                                            elevation: 5,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10))),
                                        onPressed: () {
                                          if (buzos[index].stock > 0) {
                                            final currentStock =
                                                buzos[index].stock;
                                            if (buzos[index].stock > 0) {
                                              final newStock = currentStock - 1;
                                              context.read<ArticuloBloc>().add(
                                                  UpdateStock(
                                                      articuloId:
                                                          buzos[index].id!,
                                                      newStock: newStock));
                                              Carrito nuevoCarrito = Carrito(
                                                  id: 0,
                                                  clienteCarrito:
                                                      cliente.idCliente!,
                                                  articuloCarrito:
                                                      buzos[index].id!,
                                                  cantidad: 1,
                                                  articuloNombre: buzos[index]
                                                      .nombreArticulo,
                                                  precio: buzos[index].precio,
                                                  stock: buzos[index].stock,
                                                  imagenUrl:
                                                      buzos[index].imagen);
                                              context.read<CarritoBloc>().add(
                                                  AddCarrito(nuevoCarrito));
                                            }
                                          }
                                        },
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ]));
                      },
                    );
                  } else if (state is ArticulosError) {
                    return Center(child: Text(state.message));
                  } else {
                    return const Center(child: Text('Estado desconectado'));
                  }
                },
              ),
            ));
      } else {
        return const Scaffold(
          body: Center(
            child: Text('No autenticado o estado desconocido'),
          ),
        );
      }
    });
  }
}