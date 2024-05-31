import 'package:flutter_csharp3/Administrador/screen_view_admin.dart';

class CommonScaffold extends StatelessWidget {
  final Widget body;
  final Usuario? usuario;
  final String title;
  final FloatingActionButton? floatingActionButton;

  const CommonScaffold({
    super.key,
    required this.body,
    this.usuario,
    required this.title,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: const [LogoutButton()],
      ),
      drawer:
          usuario != null ? CustomDrawer(usuario: usuario!) : const SizedBox(),
      body: body,
      floatingActionButton: floatingActionButton,
    );
  }
}
