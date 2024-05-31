abstract class WalletEvent {}

class LoadWallet extends WalletEvent {
  final int clienteId;
  LoadWallet(this.clienteId);
}

class UpdateWalletBalance extends WalletEvent {
  final int clienteId;
  final double newBalance;
  UpdateWalletBalance(this.clienteId, this.newBalance);
}

class MakeTransaction extends WalletEvent {
  final int clienteId;
  final double amount;
  MakeTransaction(this.clienteId, this.amount);
}
