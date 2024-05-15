import 'package:flutter/material.dart';
import 'package:flutter_csharp3/Administrador/BarAdmin/button_logout.dart';
import 'package:flutter_csharp3/Administrador/BarAdmin/custom_drawer.dart';
import 'package:flutter_csharp3/Administrador/BLoCAdmin/user_model.dart';

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
