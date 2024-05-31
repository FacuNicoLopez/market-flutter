import 'package:flutter_csharp3/Clientes/screen_view_client.dart';

class HomeCarrito extends StatelessWidget {
  const HomeCarrito({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginClientBloc, ClienteState>(
      builder: (context, clienteState) {
        if (clienteState is ClienteCargado) {
          final cliente = clienteState.cliente;
          return CommonScaffold(
            cliente: cliente,
            title: 'Productos en el Carrito',
            body: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color.fromRGBO(70, 169, 178, 1),
                  Color.fromRGBO(255, 231, 233, 1)
                ]),
              ),
              child: BlocBuilder<CarritoBloc, CarritoState>(
                builder: (context, stateCarrito) {
                  if (stateCarrito is CarritoLoading) {
                    return const CircularProgressIndicator();
                  } else if (stateCarrito is CarritoVacio) {
                    return const EmptyCart();
                  } else if (stateCarrito is CarritoLoaded) {
                    final double total = stateCarrito.carritos.fold(
                        0, (sum, item) => sum + (item.precio! * item.cantidad));
                    return Column(children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: stateCarrito.carritos.length,
                          itemBuilder: (context, index) {
                            final carritoItem = stateCarrito.carritos[index];
                            return BlocBuilder<ArticuloBloc, ArticuloState>(
                              builder: (context, stateArticulo) {
                                if (stateArticulo is ArticuloLoaded &&
                                    stateArticulo.articuloDetalle.id ==
                                        carritoItem.articuloCarrito) {}
                                return ClipRect(
                                  child: Column(
                                    children: [
                                      Card(
                                        elevation: 6,
                                        shadowColor: Colors.black54,
                                        margin: const EdgeInsets.all(10),
                                        child: Padding(
                                          padding: const EdgeInsets.all(20),
                                          child: ListTile(
                                            leading:
                                                carritoItem.imagenUrl != null
                                                    ? Image.network(
                                                        carritoItem.imagenUrl!,
                                                        width: 70,
                                                        height: 70,
                                                      )
                                                    : const SizedBox(
                                                        width: 50, height: 50),
                                            title: Text(
                                              carritoItem.articuloNombre ??
                                                  'Nombre no disponible',
                                            ),
                                            subtitle: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    'Precio: \$${carritoItem.precio ?? 'Precio no disponible'}'),
                                                Text(
                                                    'Cantidad: ${carritoItem.cantidad}'),
                                              ],
                                            ),
                                            trailing: Wrap(
                                              spacing: 20,
                                              children: [
                                                DropdownButton<int>(
                                                  value: carritoItem.cantidad,
                                                  items: List.generate(
                                                    carritoItem.stock ?? 1,
                                                    (index) => DropdownMenuItem(
                                                      value: index + 1,
                                                      child:
                                                          Text('${index + 1}'),
                                                    ),
                                                  ),
                                                  onChanged: (value) {
                                                    if (value != null) {
                                                      context
                                                          .read<CarritoBloc>()
                                                          .add(UpdateCartItem(
                                                              articuloId:
                                                                  carritoItem
                                                                      .articuloCarrito,
                                                              nuevaCantidad:
                                                                  value));
                                                    }
                                                  },
                                                ),
                                                IconButton(
                                                    icon: const Icon(
                                                        Icons.delete),
                                                    onPressed: () =>
                                                        showDeleteDialog(
                                                            context,
                                                            carritoItem)),
                                              ],
                                            ),
                                            isThreeLine: true,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                      Container(
                          height: 150,
                          width: 320,
                          margin: const EdgeInsets.only(bottom: 40),
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 210, 203, 203),
                              borderRadius: BorderRadius.circular(4)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Cantidad de Articulos a comprar',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              Text(
                                'TOTAL A PAGAR: \$${total.toStringAsFixed(2)}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              ElevatedButton.icon(
                                icon: const Icon(Icons.payment_rounded),
                                label: const Text('Comprar'),
                                onPressed: () {
                                  final carritoState =
                                      context.read<CarritoBloc>().state;
                                  if (carritoState is CarritoLoaded &&
                                      carritoState.carritos.isNotEmpty) {
                                    showConfirmationDialog(context);
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text(
                                          'No hay articulos en el carrito para comprar'),
                                      duration: Duration(seconds: 2),
                                    ));
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).colorScheme.secondary,
                                  foregroundColor: Colors.white,
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ]);
                  } else if (stateCarrito is CarritoError) {
                    return Text('Error en Carrito: ${stateCarrito.message}');
                  } else {
                    return const Text('Estado desconocido del Carrito');
                  }
                },
              ),
            ),
          );
        } else {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }
}
