import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_csharp3/Administrador/TarjetasAdmin/card_feed.dart';
import 'package:flutter_csharp3/Administrador/BarAdmin/bar_admin.dart';
import 'package:flutter_csharp3/Administrador/BLoCAdmin/user_bloc.dart';
import 'package:flutter_csharp3/Administrador/BLoCAdmin/user_state.dart';
import 'package:flutter_csharp3/data_card.dart';
import 'package:go_router/go_router.dart';

class CardHome extends StatefulWidget {
  const CardHome({super.key});

  @override
  _CardHomeState createState() => _CardHomeState();
}

class _CardHomeState extends State<CardHome> {
  final TextEditingController _searchController = TextEditingController();
  String _searchText = "";

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _searchText = _searchController.text.toLowerCase();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsuarioBloc, UsuarioState>(
        builder: (context, usuarioState) {
      if (usuarioState is UsuarioLoaded) {
        final usuario = usuarioState.usuario;
        final filteredCards = listCard.where((card) {
          return card['titulo']!.toLowerCase().contains(_searchText);
        }).toList();
        return CommonScaffold(
            usuario: usuario,
            title: 'Productos',
            body: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Color.fromRGBO(225, 231, 233, 1),
                  Color.fromRGBO(70, 169, 178, 1)
                ])),
                child: SafeArea(
                    child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                            labelText: 'Buscar Productos',
                            suffixIcon: const Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide:
                                  const BorderSide(color: Colors.transparent),
                            )),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: filteredCards.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              context.go(
                                  '/${filteredCards[index]['titulo']!.toLowerCase()}_admin');
                            },
                            child: CardFeed(
                              card: filteredCards[index],
                              index: index,
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ))));
      } else {
        return const Scaffold(
          body: Center(
            child: Text('Usuario no disponible'),
          ),
        );
      }
    });
  }
}
