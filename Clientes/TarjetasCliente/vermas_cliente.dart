import 'package:flutter_csharp3/Clientes/screen_view_client.dart';

class LikesCardClient extends StatelessWidget {
  final int index;
  const LikesCardClient({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      color: Colors.cyan,
      fontSize: 15,
    );

    const List<String> routes = [
      '/pantalones_cliente',
      '/remeras_cliente',
      '/shorts_cliente',
      '/camperas_cliente',
      '/buzos_cliente',
      '/sueters_cliente',
      '/zapatos_cliente',
      '/camisas_cliente'
    ];
    return Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      TextButton(
        onPressed: () {
          context.go(routes[index]);
        },
        child: const Text(
          'Ver mas',
          style: textStyle,
        ),
      ),
    ]);
  }
}
