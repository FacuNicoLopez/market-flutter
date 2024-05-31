import 'package:flutter_csharp3/Administrador/screen_view_admin.dart';

class LikesCard extends StatelessWidget {
  final int index;
  const LikesCard({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      color: Colors.cyan,
      fontSize: 15,
    );

    const List<String> routes = [
      '/pantalones_admin',
      '/remeras_admin',
      '/shorts_admin',
      '/camperas_admin',
      '/buzos_admin',
      '/sueters_admin',
      '/zapatos_admin',
      '/camisas_admin'
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
