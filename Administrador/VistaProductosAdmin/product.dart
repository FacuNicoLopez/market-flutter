import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_csharp3/Administrador/VistaProductosAdmin/add_product.dart';
import 'package:flutter_csharp3/Administrador/VistaProductosAdmin/delete_product.dart';
import 'package:flutter_csharp3/Administrador/VistaProductosAdmin/edit_product.dart';
import 'package:flutter_csharp3/Producto/product_bloc.dart';
import 'package:flutter_csharp3/Administrador/BLoCAdmin/user_bloc.dart';
import 'package:flutter_csharp3/Producto/product_state.dart';
import 'package:flutter_csharp3/Administrador/BLoCAdmin/user_state.dart';
import 'package:flutter_csharp3/Administrador/BarAdmin/bar_admin.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsuarioBloc, UsuarioState>(
      builder: (context, usuarioState) {
        if (usuarioState is UsuarioLoaded) {
          final usuario = usuarioState.usuario;
          return CommonScaffold(
            usuario: usuario,
            title: 'Ajuste Productos',
            body: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color.fromRGBO(225, 231, 233, 1),
                  Color.fromRGBO(70, 169, 178, 1)
                ]),
              ),
              child: BlocBuilder<ArticuloBloc, ArticuloState>(
                builder: (context, state) {
                  if (state is ArticulosLoading) {
                    return const CircularProgressIndicator();
                  } else if (state is ArticulosLoaded) {
                    return ListView.separated(
                      itemCount: state.articulos.length,
                      separatorBuilder: (_, __) => const Divider(
                        color: Colors.white,
                        thickness: 1,
                      ),
                      itemBuilder: (context, index) {
                        final articulo = state.articulos[index];
                        return Container(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      articulo.nombreArticulo,
                                      style: const TextStyle(
                                        color: Color.fromARGB(255, 72, 71, 71),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        articulo.imagen != null
                                            ? Container(
                                                width: 60,
                                                height: 60,
                                                decoration: BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(0.3),
                                                      spreadRadius: 1,
                                                      blurRadius: 3,
                                                      offset:
                                                          const Offset(0, 1),
                                                    )
                                                  ],
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                ),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                  child: Image.network(
                                                    articulo.imagen!,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              )
                                            : const Icon(
                                                Icons.image_not_supported,
                                                size: 50),
                                        const SizedBox(width: 10),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Talle: ${articulo.talle}',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(
                                                    255, 69, 67, 67),
                                                fontSize: 14,
                                              ),
                                            ),
                                            Text(
                                              'Precio: ${articulo.precio}',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(
                                                    255, 69, 67, 67),
                                                fontSize: 14,
                                              ),
                                            ),
                                            Text(
                                              'Stock: ${articulo.stock}',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(
                                                    255, 69, 67, 67),
                                                fontSize: 14,
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  iconButtonWithShadow(Icons.edit, Colors.green,
                                      () => showEditDialog(context, articulo)),
                                  const SizedBox(width: 8),
                                  iconButtonWithShadow(
                                      Icons.delete,
                                      Colors.red,
                                      () =>
                                          showDeleteDialog(context, articulo)),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  } else if (state is ArticulosError) {
                    return Text(state.message);
                  } else {
                    return const Text('Unknown state');
                  }
                },
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => showAddDialog(context),
              tooltip: 'Agregar Artículo',
              backgroundColor:
                  const Color.fromARGB(255, 0, 226, 0).withOpacity(0.8),
              child: const Icon(Icons.add),
            ),
          );
        } else {
          return const Scaffold(
            body: Center(
              child: Text('Usuario no disponible'),
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
        color: Colors.white.withOpacity(0.8),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 1,
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
