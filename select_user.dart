import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SelectPage extends StatelessWidget {
  const SelectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(
              child: Text('SELECCIONAR TIPO USUARIO',
                  style: TextStyle(color: Colors.white))),
          backgroundColor: const Color.fromARGB(255, 107, 170, 182),
        ),
        body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 255, 255, 255),
                  Color.fromARGB(255, 15, 134, 158),
                ],
              ),
            ),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Center(
                child: Container(
                  width: 300,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: buttonWithStyledText(
                            context, 'Ingreso\nAdministrador', '/login_admin'),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: buttonWithStyledText(
                            context, 'Ingreso\nCliente', '/login_client'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text('No tienes cuenta administrador?'),
              TextButton(
                onPressed: () {
                  context.go('/create_admin');
                },
                child: const Text(
                  'Crear Nueva Cuenta',
                  style: TextStyle(color: Color.fromARGB(255, 223, 216, 216)),
                ),
              )
            ])));
  }

  Widget buttonWithStyledText(
      BuildContext context, String label, String route) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromARGB(255, 130, 243, 255),
            Color.fromARGB(255, 8, 90, 110)
          ],
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ElevatedButton(
        onPressed: () {
          context.go(route);
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
