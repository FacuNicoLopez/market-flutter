import 'package:flutter_csharp3/Administrador/screen_view_admin.dart';

class CrearAdmin extends StatelessWidget {
  const CrearAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final claveController = TextEditingController();
    final nombreController = TextEditingController();
    final apellidoController = TextEditingController();
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.go('/');
          },
          backgroundColor: Colors.white.withOpacity(0.5),
          child: const Icon(Icons.arrow_back),
        ),
        appBar: AppBar(
          title: const Text('CREAR CUENTA ADMINISTRADOR'),
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
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Container(
                height: 400,
                width: 300,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromARGB(255, 150, 142, 142),
                        blurRadius: 4,
                        spreadRadius: 4,
                        offset: Offset(0, 1),
                      )
                    ]),
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(color: Colors.white)),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: claveController,
                      obscureText: true,
                      decoration: const InputDecoration(
                          labelText: 'Clave',
                          labelStyle: TextStyle(color: Colors.white)),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: nombreController,
                      decoration: const InputDecoration(
                          labelText: 'Nombre',
                          labelStyle: TextStyle(color: Colors.white)),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: apellidoController,
                      decoration: const InputDecoration(
                          labelText: 'Apellido',
                          labelStyle: TextStyle(color: Colors.white)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextButton(
                        onPressed: () {
                          if (emailController.text.isEmpty ||
                              claveController.text.isEmpty ||
                              nombreController.text.isEmpty ||
                              apellidoController.text.isEmpty) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content:
                                  Text('Porfavor, complete todos los campos'),
                              backgroundColor: Colors.red,
                            ));
                            return;
                          }
                          try {
                            final nuevoUsuario = Usuario(
                                token: '',
                                email: emailController.text,
                                password: claveController.text,
                                nameUser: nombreController.text,
                                apellido: apellidoController.text);
                            BlocProvider.of<UsuarioAddDeleteBloc>(context)
                                .add(AddUser(nuevoUsuario));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("Nuevo usuario creado"),
                              duration: Duration(seconds: 2),
                            ));
                            context.go('/');
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Error al crear: ${e.toString()}'),
                              backgroundColor: Colors.red,
                            ));
                          }
                        },
                        style: TextButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 63, 62, 62),
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 24)),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.person_add_rounded,
                              color: Colors.white,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Crear Administrador',
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ))
                  ],
                ),
              ),
            )));
  }
}
