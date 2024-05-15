import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_csharp3/Administrador/BLoCAdmin/user_model.dart';
import 'package:flutter_csharp3/Administrador/ProductoAdmin/buzos_admin.dart';
import 'package:flutter_csharp3/Administrador/ProductoAdmin/camisas_admin.dart';
import 'package:flutter_csharp3/Administrador/ProductoAdmin/camperas_admin.dart';
import 'package:flutter_csharp3/Administrador/ProductoAdmin/pantalones_admin.dart';
import 'package:flutter_csharp3/Administrador/ProductoAdmin/remeras_admin.dart';
import 'package:flutter_csharp3/Administrador/ProductoAdmin/shorts_admin.dart';
import 'package:flutter_csharp3/Administrador/ProductoAdmin/sueters_admin.dart';
import 'package:flutter_csharp3/Administrador/ProductoAdmin/zapatos_admin.dart';
import 'package:flutter_csharp3/Administrador/TarjetasAdmin/card.dart';
import 'package:flutter_csharp3/Administrador/VistaClientesAdmin/client.dart';
import 'package:flutter_csharp3/Administrador/home_admin.dart';
import 'package:flutter_csharp3/Administrador/VistaProductosAdmin/product.dart';
import 'package:flutter_csharp3/Clientes/BLoCCliente/client_model.dart';
import 'package:flutter_csharp3/Clientes/CarritoCliente/carrito.dart';
import 'package:flutter_csharp3/Clientes/ProductoCliente/buzos_cliente.dart';
import 'package:flutter_csharp3/Clientes/ProductoCliente/camisas_cliente.dart';
import 'package:flutter_csharp3/Clientes/ProductoCliente/camperas_cliente.dart';
import 'package:flutter_csharp3/Clientes/ProductoCliente/pantalones_cliente.dart';
import 'package:flutter_csharp3/Clientes/ProductoCliente/remeras_cliente.dart';
import 'package:flutter_csharp3/Clientes/ProductoCliente/shorts_cliente.dart';
import 'package:flutter_csharp3/Clientes/ProductoCliente/sueters_cliente.dart';
import 'package:flutter_csharp3/Clientes/ProductoCliente/zapatos_cliente.dart';
import 'package:flutter_csharp3/Clientes/TarjetasCliente/card_client.dart';
import 'package:flutter_csharp3/Clientes/home_client.dart';
import 'package:flutter_csharp3/login_admin.dart';
import 'package:flutter_csharp3/login_client.dart';
import 'package:flutter_csharp3/select_user.dart';
import 'package:go_router/go_router.dart';

final GoRouter routerPublic = GoRouter(
  routes: [
    //ADMINISTRADOR
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) =>
          const SelectPage(),
    ),
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

    //ClIENTES
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
      builder: (BuildContext context, GoRouterState state) =>
          const HomeCarrito(),
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
