import 'package:flutter_csharp3/Administrador/screen_view_admin.dart';

class CuentaAdmin extends StatelessWidget {
  const CuentaAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsuarioBloc, UsuarioState>(
        builder: (context, usuarioState) {
      if (usuarioState is UsuarioLoaded) {
        final usuario = usuarioState.usuario;
        return CommonScaffold(
            usuario: usuario,
            title: 'Ajuste Cuenta',
            body: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color.fromRGBO(225, 231, 233, 1),
                  Color.fromRGBO(70, 169, 178, 1)
                ]),
              ),
              child: Column(
                children: [
                  Expanded(
                    child:
                        ListView(padding: const EdgeInsets.all(8), children: [
                      ListTile(
                        enabled: false,
                        leading: const Icon(Icons.person),
                        title: const Text(
                          'Id del USuario',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 62, 60, 60)),
                        ),
                        subtitle: Text(usuario.userId?.toString() ?? 'N/A'),
                      ),
                      ListTile(
                        enabled: false,
                        leading: const Icon(Icons.email),
                        title: const Text(
                          'Email',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 62, 60, 60)),
                        ),
                        subtitle: Text(usuario.email),
                      ),
                      const ListTile(
                        enabled: false,
                        leading: Icon(Icons.lock),
                        title: Text(
                          'Contraseña',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 62, 60, 60)),
                        ),
                        subtitle: Text('******'),
                      ),
                      ListTile(
                        enabled: false,
                        leading: const Icon(Icons.co_present_rounded),
                        title: const Text(
                          'Nombre',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 62, 60, 60)),
                        ),
                        subtitle: Text(usuario.nameUser.toString()),
                      ),
                      ListTile(
                        enabled: false,
                        leading: const Icon(Icons.co_present_rounded),
                        title: const Text(
                          'Apellido',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 62, 60, 60)),
                        ),
                        subtitle: Text(usuario.apellido.toString()),
                      ),
                    ]),
                  )
                ],
              ),
            ));
      } else {
        return const Scaffold(body: Text('No se puede conectar'));
      }
    });
  }
}
