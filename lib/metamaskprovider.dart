import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_web3/flutter_web3.dart';

class MetaMaskProvider extends ChangeNotifier {
  String currentAddress = "";
  int currentChain = -1;

  bool get isEnabled => ethereum != null;

  bool get isConnected => isEnabled && currentAddress.isNotEmpty;

  BigInt balance = BigInt.from(-1);

  BigInt get getBalance => balance;

  String get getNetworkName {
    if (networkName == "homestead") {
      return "Ethereum";
    }
    return "matic";
  }

  String networkName = "";

  Future<void> connect() async {
    if (isEnabled) {
      final accs = await ethereum!.requestAccount();
      if (accs.isNotEmpty) currentAddress = accs.first;

      currentChain = await ethereum!.getChainId();

      final web3provider = Web3Provider.fromEthereum(ethereum!);
      Network network = await web3provider.getNetwork();
      networkName = network.name;

      balance = await web3provider.getBalance(currentAddress);

      notifyListeners();
    }
  }

  clear() {
    currentAddress = "";
    currentChain = -1;

    notifyListeners();
  }

  init() {
    if (isEnabled) {
      ethereum!.onAccountsChanged((accounts) {
        clear();
      });
      ethereum!.onChainChanged((accounts) {
        clear();
      });
    }
  }

  //Animation:

  bool isanim = false;

  animate() {
    isanim = !isanim;
    notifyListeners();
  }
}
