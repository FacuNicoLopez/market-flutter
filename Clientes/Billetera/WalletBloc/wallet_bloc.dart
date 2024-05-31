import 'dart:convert';
import 'package:flutter_csharp3/Clientes/screen_view_client.dart';
import 'package:http/http.dart' as http;

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  final LoginClientBloc loginClientBloc;

  final url9 = direccionUrl;

  WalletBloc(this.loginClientBloc) : super(WalletLoading()) {
    on<LoadWallet>(_onLoadWallet);
    on<UpdateWalletBalance>(_onUpdateWalletBalance);
    on<MakeTransaction>(_onMakeTransaction);
  }

  Future<void> _onLoadWallet(
      LoadWallet event, Emitter<WalletState> emit) async {
    if (loginClientBloc.clienteActual == null ||
        loginClientBloc.clienteActual!.idCliente == null) {
      emit(WalletError(
          'Cliente no cargado en LoginClientBloc o idCliente es nulo'));
      return;
    }
    emit(WalletLoading());
    try {
      final response = await http.get(Uri.parse(
          '$url9/billetera/${loginClientBloc.clienteActual!.idCliente}/saldo'));
      if (response.statusCode == 200) {
        final saldo = double.parse(response.body);
        emit(WalletLoaded(saldo));
      } else {
        emit(WalletError('Error loading wallet'));
      }
    } catch (e) {
      emit(WalletError('Error loading wallet: ${e.toString()}'));
    }
  }

  Future<void> _onUpdateWalletBalance(
      UpdateWalletBalance event, Emitter<WalletState> emit) async {
    try {
      final billetera = Billetera(
        clienteId: event.clienteId,
        monto: event.newBalance.toInt(),
        tipoTransaccion: 'retiro',
      );

      final response = await http.post(
        Uri.parse('$url9/transaccion'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: billeteraToJson(billetera),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        emit(WalletLoaded(data['SaldoActual']));
      } else {
        emit(WalletError('Error Updating wallet balance'));
      }
    } catch (e) {
      emit(WalletError('Error updating wallet balance: ${e.toString()}'));
    }
  }

  Future<void> _onMakeTransaction(
      MakeTransaction event, Emitter<WalletState> emit) async {
    try {
      final billetera = Billetera(
        clienteId: event.clienteId,
        monto: event.amount.toInt(),
        tipoTransaccion: 'retiro',
      );

      final response = await http.post(
        Uri.parse('$url9/transaccion'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: billeteraToJson(billetera),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        emit(WalletTransactionSuccess(data['SaldoActual']));
      } else {
        emit(WalletError('Error making transaction'));
      }
    } catch (e) {
      emit(WalletError('Error making transaction: ${e.toString()}'));
    }
  }
}
