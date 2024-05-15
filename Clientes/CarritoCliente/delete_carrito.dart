import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_csharp3/Clientes/CarritoCliente/carrito_bloc.dart';
import 'package:flutter_csharp3/Clientes/CarritoCliente/carrito_event.dart';
import 'package:flutter_csharp3/Clientes/CarritoCliente/carrito_model.dart';
import 'package:flutter_csharp3/Producto/product_bloc.dart';
import 'package:flutter_csharp3/Producto/product_event.dart';

void showDeleteDialog(BuildContext context, Carrito carritoItem) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar Eliminación'),
          content: const Text(
              '¿Estás seguro de que deseas eliminar este artículo del carrito?'),
          actions: [
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text(
                'Eliminar',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                if (carritoItem.id != 0) {
                  context
                      .read<CarritoBloc>()
                      .add(RemoveItemFromCart(carritoItem.id));
                  int newStock =
                      (carritoItem.stock ?? 0) + (carritoItem.cantidad);
                  context.read<ArticuloBloc>().add(UpdateStock(
                      articuloId: carritoItem.articuloCarrito,
                      newStock: newStock));
                  Navigator.of(context).pop();
                } else {
                  Navigator.of(context).pop();
                }
              },
            )
          ],
        );
      });
}
