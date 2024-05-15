import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_csharp3/Administrador/ImagenBarAdmin/bloc_image_admin.dart';
import 'package:flutter_csharp3/Clientes/BLoCCliente/cliente_bloc.dart';
import 'package:flutter_csharp3/Clientes/CarritoCliente/carrito_bloc.dart';
import 'package:flutter_csharp3/Clientes/CarritoCliente/carrito_event.dart';
import 'package:flutter_csharp3/Clientes/ImagenBarCliente/bloc_image_client.dart';
import 'package:flutter_csharp3/Producto/product_bloc.dart';
import 'package:flutter_csharp3/Administrador/BLoCAdmin/user_bloc.dart';
import 'package:flutter_csharp3/Clientes/BLoCCliente/client_event.dart';
import 'package:flutter_csharp3/Producto/product_event.dart';
import 'package:flutter_csharp3/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UsuarioBloc>(
          create: (context) => UsuarioBloc(),
        ),
        BlocProvider<LoginClientBloc>(
          create: (context) => LoginClientBloc(),
        ),
        BlocProvider<ArticuloBloc>(
          create: (context) => ArticuloBloc()..add(LoadArticulos()),
        ),
        BlocProvider<ClienteBloc>(
          create: (context) => ClienteBloc()..add(LoadClientes()),
        ),
        BlocProvider<ImagenBloc>(
          create: (context) => ImagenBloc(),
        ),
        BlocProvider<ImagenBlocClient>(
          create: (context) => ImagenBlocClient(),
        ),
        BlocProvider<CarritoBloc>(
            create: (context) => CarritoBloc(context.read<LoginClientBloc>())
              ..add(LoadCartItems())),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: routerPublic,
        title: "Welcome",
      ),
    );
  }
}
