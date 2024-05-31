import 'package:flutter_csharp3/Clientes/screen_view_client.dart';

class SuccessPage extends StatelessWidget {
  const SuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pago Exitoso'),
      ),
      body: const Center(
        child: Text('Pago Realizado con Exito!'),
      ),
    );
  }
}
