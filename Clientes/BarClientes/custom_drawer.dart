import 'package:flutter_csharp3/Clientes/screen_view_client.dart';

class CustomDrawer extends StatelessWidget {
  final Cliente cliente;
  const CustomDrawer({super.key, required this.cliente});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey.withOpacity(0.8),
      child: BlocBuilder<ImagenBlocClient, ImagenStateClient>(
        builder: (context, state) {
          if (state is ImagenLoadedClient) {
            ThemeData themeData = state.themeModeClient == ThemeMode.dark
                ? ThemeData.dark()
                : ThemeData.light();

            return Theme(
                data: themeData,
                child: ListView(
                  children: [
                    DrawerHeader(
                      decoration: BoxDecoration(
                        color: themeData.primaryColor,
                        image: DecorationImage(
                          image: NetworkImage(state.mainImageUrlClient),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Text('Cliente: ${cliente.nombreCliente}',
                            style: TextStyle(
                                fontSize: 24,
                                color: themeData.colorScheme.secondary)),
                      ),
                    ),
                    ListTile(
                      tileColor: themeData.colorScheme.surface,
                      leading:
                          Icon(Icons.home, color: themeData.iconTheme.color),
                      title: Text('Principal',
                          style: themeData.textTheme.bodyLarge),
                      onTap: () {
                        context.go('/card_client');
                      },
                    ),
                    ListTile(
                      tileColor: themeData.colorScheme.surface,
                      leading:
                          Icon(Icons.wallet, color: themeData.iconTheme.color),
                      title: Text('Billetera',
                          style: themeData.textTheme.bodyLarge),
                      onTap: () {
                        context.go('/wallet');
                      },
                    ),
                    ListTile(
                      tileColor: themeData.colorScheme.surface,
                      title: Text('Cambiar Tema e Imagen',
                          style: themeData.textTheme.bodyLarge),
                      onTap: () {
                        context
                            .read<ImagenBlocClient>()
                            .add(ToggleImagenThemeEvent());
                      },
                    ),
                  ],
                ));
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
