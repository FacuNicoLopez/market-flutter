import 'dart:convert';

import 'package:flutter_csharp3/Administrador/screen_view_admin.dart';
import 'package:flutter_csharp3/Clientes/screen_view_client.dart';

final GoRouter routerPublic = GoRouter(
  routes: [
    //-----------ADMINISTRADOR---------
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) =>
          const SelectPage(),
    ),

    GoRoute(
        path: '/create_admin',
        builder: (BuildContext context, GoRouterState state) =>
            const CrearAdmin()),
    GoRoute(
      path: '/login_admin',
      builder: (BuildContext context, GoRouterState state) =>
          const LoginAdmin(),
    ),
    GoRoute(
      path: '/home_admin',
      builder: (BuildContext context, GoRouterState state) =>
          HomePage(usuario: state.extra as Usuario),
    ),
    GoRoute(
      path: '/settings',
      builder: (BuildContext context, GoRouterState state) =>
          const CuentaAdmin(),
    ),
    GoRoute(
      path: '/clientes',
      builder: (BuildContext context, GoRouterState state) =>
          const ClientUser(),
    ),
    GoRoute(
        path: '/card',
        builder: (BuildContext context, GoRouterState state) =>
            const CardHome()),
    GoRoute(
        path: '/product',
        builder: (BuildContext context, GoRouterState state) =>
            const ProductPage()),
    GoRoute(
      path: '/buzos_admin',
      builder: (BuildContext context, GoRouterState state) => const BuzoAdmin(),
    ),
    GoRoute(
      path: '/camperas_admin',
      builder: (BuildContext context, GoRouterState state) =>
          const CamperaAdmin(),
    ),
    GoRoute(
      path: '/pantalones_admin',
      builder: (BuildContext context, GoRouterState state) =>
          const PantalonAdmin(),
    ),
    GoRoute(
      path: '/remeras_admin',
      builder: (BuildContext context, GoRouterState state) =>
          const RemeraAdmin(),
    ),
    GoRoute(
      path: '/shorts_admin',
      builder: (BuildContext context, GoRouterState state) =>
          const ShortAdmin(),
    ),
    GoRoute(
      path: '/sueters_admin',
      builder: (BuildContext context, GoRouterState state) =>
          const SueterAdmin(),
    ),
    GoRoute(
      path: '/zapatos_admin',
      builder: (BuildContext context, GoRouterState state) =>
          const ZapatoAdmin(),
    ),
    GoRoute(
      path: '/camisas_admin',
      builder: (BuildContext context, GoRouterState state) =>
          const CamisaAdmin(),
    ),

    //-----------ClIENTES----------
    GoRoute(
      path: '/home_client',
      builder: (BuildContext context, GoRouterState state) =>
          HomeClient(cliente: state.extra as Cliente),
    ),
    GoRoute(
      path: '/login_client',
      builder: (BuildContext context, GoRouterState state) =>
          const LoginClient(),
    ),
    GoRoute(
      path: '/wallet',
      builder: (BuildContext context, GoRouterState state) =>
          const WalletClient(),
    ),
    GoRoute(
      path: '/success_mp',
      builder: (BuildContext context, GoRouterState state) =>
          const SuccessPage(),
    ),
    GoRoute(
        path: '/card_client',
        builder: (BuildContext context, GoRouterState state) =>
            const CardHomeClient()),
    GoRoute(
      path: '/buzos_cliente',
      builder: (BuildContext context, GoRouterState state) =>
          const BuzoCliente(),
    ),
    GoRoute(
      path: '/camperas_cliente',
      builder: (BuildContext context, GoRouterState state) =>
          const CamperaCliente(),
    ),
    GoRoute(
      path: '/pantalones_cliente',
      builder: (BuildContext context, GoRouterState state) =>
          const PantalonCliente(),
    ),
    GoRoute(
      path: '/remeras_cliente',
      builder: (BuildContext context, GoRouterState state) =>
          const RemeraCliente(),
    ),
    GoRoute(
      path: '/shorts_cliente',
      builder: (BuildContext context, GoRouterState state) =>
          const ShortCliente(),
    ),
    GoRoute(
      path: '/sueters_cliente',
      builder: (BuildContext context, GoRouterState state) =>
          const SueterCliente(),
    ),
    GoRoute(
      path: '/zapatos_cliente',
      builder: (BuildContext context, GoRouterState state) =>
          const ZapatoCliente(),
    ),
    GoRoute(
      path: '/camisas_cliente',
      builder: (BuildContext context, GoRouterState state) =>
          const CamisaCliente(),
    ),
    GoRoute(
      path: '/carrito',
      builder: (BuildContext context, GoRouterState state) {
        context.read<CarritoBloc>().add(LoadCartItems());
        return const HomeCarrito();
      },
    ),
  ],
  extraCodec: const UsuarioExtraCodec(),
);

class UsuarioExtraCodec extends Codec<Object?, Object?> {
  const UsuarioExtraCodec();

  @override
  Converter<Object?, Object?> get decoder => const _UsuarioExtraDecoder();

  @override
  Converter<Object?, Object?> get encoder => const _UsuarioExtraEncoder();
}

class _UsuarioExtraDecoder extends Converter<Object?, Object?> {
  const _UsuarioExtraDecoder();

  @override
  Object? convert(Object? input) {
    if (input == null) return null;
    final Map<String, dynamic> inputAsMap =
        Map<String, dynamic>.from(input as Map);
    return Usuario.fromMap(inputAsMap);
  }
}

class _UsuarioExtraEncoder extends Converter<Object?, Object?> {
  const _UsuarioExtraEncoder();

  @override
  Object? convert(Object? input) {
    if (input == null) return null;
    if (input is Usuario) {
      return input.toMap();
    } else if (input is Cliente) {
      return input.toJson();
    }
    throw FormatException('Cannot encode type ${input.runtimeType}');
  }
}
