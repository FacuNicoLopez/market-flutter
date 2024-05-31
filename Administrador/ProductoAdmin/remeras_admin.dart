import 'package:flutter_csharp3/Administrador/screen_view_admin.dart';

class RemeraAdmin extends StatelessWidget {
  const RemeraAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ArticuloBloc>().add(LoadArticulos());

    return BlocBuilder<UsuarioBloc, UsuarioState>(
        builder: (context, usuarioState) {
      if (usuarioState is UsuarioLoaded) {
        final usuario = usuarioState.usuario;
        return CommonScaffold(
            usuario: usuario,
            title: 'Remeras',
            body: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color.fromRGBO(225, 231, 233, 1),
                  Color.fromRGBO(70, 169, 178, 1)
                ]),
              ),
              child: BlocBuilder<ArticuloBloc, ArticuloState>(
                builder: (context, state) {
                  if (state is ArticulosLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ArticulosLoaded) {
                    var remeras = state.articulos
                        .where((art) =>
                            art.nombreArticulo.toLowerCase().contains('remera'))
                        .toList();
                    return ListView.builder(
                      itemCount: remeras.length,
                      itemBuilder: (context, index) {
                        return Container(
                            height: 450,
                            margin: const EdgeInsets.all(22),
                            decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                  blurRadius: 10,
                                  spreadRadius: 1,
                                ),
                              ],
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(children: [
                              Padding(
                                padding: const EdgeInsets.all(12),
                                child: Text(
                                  remeras[index].nombreArticulo,
                                  style: const TextStyle(
                                    fontSize: 22,
                                    color: Color.fromARGB(255, 29, 35, 40),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                    bottom: Radius.circular(10)),
                                child: Image.network(
                                  remeras[index].imagen,
                                  width: double.infinity,
                                  height: 350,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Precio: ${remeras[index].precio}',
                                          style: const TextStyle(fontSize: 16)),
                                      Text(
                                          'Stock disponibles: ${remeras[index].stock}',
                                          style: const TextStyle(fontSize: 16))
                                    ],
                                  ))
                            ]));
                      },
                    );
                  } else if (state is ArticulosError) {
                    return Center(child: Text(state.message));
                  } else {
                    return const Center(child: Text('Estado desconectado'));
                  }
                },
              ),
            ));
      } else {
        return const Scaffold(
          body: Center(
            child: Text('No autenticado o estado desconocido'),
          ),
        );
      }
    });
  }
}
