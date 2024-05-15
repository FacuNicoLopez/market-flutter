import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_csharp3/Clientes/BLoCCliente/cliente_bloc.dart';
import 'package:flutter_csharp3/Clientes/TarjetasCliente/card_feed.dart';
import 'package:flutter_csharp3/data_card.dart';
import 'package:flutter_csharp3/Clientes/BarClientes/bar_client.dart';
import 'package:flutter_csharp3/Clientes/BLoCCliente/client_state.dart';
import 'package:go_router/go_router.dart';

class CardHomeClient extends StatefulWidget {
  const CardHomeClient({super.key});

  @override
  _CardHomeClientState createState() => _CardHomeClientState();
}

class _CardHomeClientState extends State<CardHomeClient> {
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
    return BlocBuilder<LoginClientBloc, ClienteState>(
      builder: (context, clienteState) {
        if (clienteState is ClienteCargado) {
          final cliente = clienteState.cliente;
          final filteredCards = listCard.where((card) {
            return card['titulo']!.toLowerCase().contains(_searchText);
          }).toList();

          return CommonScaffold(
              cliente: cliente,
              title: 'Lista de Productos',
              body: Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(colors: [
                    Color.fromRGBO(70, 169, 178, 1),
                    Color.fromRGBO(255, 231, 233, 1)
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
                                  borderSide: const BorderSide(
                                      color: Colors.transparent),
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
                                      '/${filteredCards[index]['titulo']!.toLowerCase()}_cliente');
                                },
                                child: CardFeedCliente(
                                  card: filteredCards[index],
                                  index: index,
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  )));
        } else {
          return const Scaffold(
            body: Center(child: Text('Usuario no disponible')),
          );
        }
      },
    );
  }
}
