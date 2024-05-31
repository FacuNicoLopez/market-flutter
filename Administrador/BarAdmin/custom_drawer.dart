import 'package:flutter_csharp3/Administrador/screen_view_admin.dart';

class CustomDrawer extends StatelessWidget {
  final Usuario usuario;
  const CustomDrawer({super.key, required this.usuario});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey.withOpacity(0.8),
      child: BlocBuilder<ImagenBloc, ImagenState>(
        builder: (context, state) {
          if (state is ImagenLoaded) {
            ThemeData themeData = state.themeMode == ThemeMode.dark
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
                          image: NetworkImage(state.mainImageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Text('Usuario: ${usuario.nameUser}',
                            style: TextStyle(
                                fontSize: 24,
                                color: themeData.colorScheme.secondary)),
                      ),
                    ),
                    ListTile(
                      tileColor: themeData.colorScheme.background,
                      leading:
                          Icon(Icons.home, color: themeData.iconTheme.color),
                      title: Text('Principal',
                          style: themeData.textTheme.bodyLarge),
                      onTap: () {
                        context.go('/card');
                      },
                    ),
                    ListTile(
                      tileColor: themeData.colorScheme.background,
                      leading: Icon(Icons.shopping_bag_rounded,
                          color: themeData.iconTheme.color),
                      title: Text('Ajuste Productos',
                          style: themeData.textTheme.bodyLarge),
                      onTap: () {
                        context.go('/product');
                      },
                    ),
                    ListTile(
                      tileColor: themeData.colorScheme.background,
                      leading: Icon(Icons.co_present_rounded,
                          color: themeData.iconTheme.color),
                      title: Text('Ajuste Clientes',
                          style: themeData.textTheme.bodyLarge),
                      onTap: () {
                        context.go('/clientes');
                      },
                    ),
                    ListTile(
                      tileColor: themeData.colorScheme.background,
                      leading: Icon(Icons.settings,
                          color: themeData.iconTheme.color),
                      title: Text('Ajuste Cuenta',
                          style: themeData.textTheme.bodyLarge),
                      onTap: () {
                        context.go('/settings');
                      },
                    ),
                    ListTile(
                      tileColor: themeData.colorScheme.background,
                      title: Text('Cambiar Tema e Imagen',
                          style: themeData.textTheme.bodyLarge),
                      onTap: () {
                        context
                            .read<ImagenBloc>()
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
