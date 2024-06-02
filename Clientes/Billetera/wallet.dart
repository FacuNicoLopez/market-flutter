import 'package:flutter_csharp3/Clientes/screen_view_client.dart';

class WalletClient extends StatelessWidget {
  const WalletClient({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginClientBloc, ClienteState>(
      builder: (context, clienteState) {
        if (clienteState is ClienteCargado) {
          final cliente = clienteState.cliente;
          context.read<WalletBloc>().add(LoadWallet(cliente.idCliente!));
          return BlocBuilder<WalletBloc, WalletState>(
            builder: (context, walletState) {
              if (walletState is WalletLoaded) {
                final saldoCliente = walletState.saldo;
                return CommonScaffold(
                  cliente: cliente,
                  title: 'Cartera',
                  body: Center(
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color.fromRGBO(70, 169, 178, 1),
                            Color.fromRGBO(255, 231, 233, 1),
                          ],
                        ),
                      ),
                      child: Center(
                        child: Container(
                          width: 350,
                          height: 500,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 59, 58, 58),
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: const [
                              BoxShadow(
                                spreadRadius: 3,
                                blurRadius: 7,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              const SizedBox(height: 10),
                              const Text(
                                'Saldo Actual',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                '\$${saldoCliente.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                'Agregar fondos desde:',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              const SizedBox(height: 20),
                              Column(
                                children: [
                                  Container(
                                    width: 200,
                                    height: 60,
                                    margin: const EdgeInsets.all(5),
                                    child: TextButton(
                                      onPressed: () {
                                        context.go('/success_mp');
                                      },
                                      style: TextButton.styleFrom(
                                        backgroundColor: Colors.cyan,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                      child: const Text(
                                        'Transferir',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              } else if (walletState is WalletError) {
                return const Scaffold(
                  body: Center(
                    child: Text('Error al cargar la cartera'),
                  ),
                );
              } else {
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              }
            },
          );
        } else {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }
}
