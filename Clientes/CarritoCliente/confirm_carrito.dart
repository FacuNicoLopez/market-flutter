import 'package:flutter_csharp3/Clientes/screen_view_client.dart';

void showConfirmationDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Confirmar Compra'),
          content: const Text(
            '¿Estás seguro de que quieres realizar esta compra?',
            style: TextStyle(color: Color.fromARGB(255, 74, 73, 73)),
          ),
          actions: [
            TextButton(
              child: const Text(
                'Cancelar',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
            TextButton(
              child: const Text(
                'Confirmar',
                style:
                    TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                final carritoState = context.read<CarritoBloc>().state;
                final walletState = context.read<WalletBloc>().state;
                final loginClienteBloc = context.read<LoginClientBloc>().state;
                if (carritoState is CarritoLoaded &&
                    walletState is WalletLoaded &&
                    loginClienteBloc is ClienteCargado) {
                  final carritos = carritoState.carritos;
                  final totalCost = carritos.fold<double>(
                    0,
                    (double sum, item) => sum + (item.precio! * item.cantidad),
                  );

                  if (walletState.saldo >= totalCost) {
                    for (final carrito in carritos) {
                      if (carrito.stock != null && carrito.cantidad != 0) {
                        final newStock = carrito.stock! - carrito.cantidad;
                        if (newStock >= 0) {
                          context.read<ArticuloBloc>().add(UpdateStock(
                              articuloId: carrito.articuloCarrito,
                              newStock: newStock));
                        }
                      }
                    }

                    final clienteId = loginClienteBloc.cliente.idCliente!;
                    context
                        .read<WalletBloc>()
                        .add(MakeTransaction(clienteId, totalCost));
                    context.read<CarritoBloc>().add(ClearCarrito());
                    Navigator.of(dialogContext).pop();
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Compra realizada con éxito!'),
                      duration: Duration(seconds: 2),
                    ));
                    context.go('/card_client');
                  } else {
                    Navigator.of(dialogContext).pop();
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Saldo insuficiente en la billetera'),
                      duration: Duration(seconds: 2),
                    ));
                  }
                }
              },
            )
          ],
        );
      });
}
