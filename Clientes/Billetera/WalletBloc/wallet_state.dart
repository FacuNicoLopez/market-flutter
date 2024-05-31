abstract class WalletState {}

class WalletLoading extends WalletState {}

class WalletLoaded extends WalletState {
  final double saldo;
  WalletLoaded(this.saldo);
}

class WalletError extends WalletState {
  final String message;
  WalletError(this.message);
}

class WalletTransactionSuccess extends WalletState {
  final double saldoActual;
  WalletTransactionSuccess(this.saldoActual);
}
