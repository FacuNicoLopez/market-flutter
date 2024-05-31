import 'package:flutter_csharp3/Clientes/screen_view_client.dart';

class EmptyCart extends StatelessWidget {
  const EmptyCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
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
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const Text(
              'TOTAL A PAGAR: \$0.00',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.payment_rounded),
              label: const Text('Comprar'),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('No hay articulos en el carrito para comprar'),
                  duration: Duration(seconds: 2),
                ));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                foregroundColor: Colors.white,
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
