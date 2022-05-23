// ignore_for_file: file_names

/*
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_web3/flutter_web3.dart';

class MetaMaskProvider extends ChangeNotifier {
  static const operatingChain = 4;
  static String currentAddress = "";
  int currentChain = -1;

  bool get isEnabled => ethereum != null;

  bool get isInOperatingChain => currentChain == operatingChain;

  bool get isConnected => isEnabled && currentAddress.isNotEmpty;

  Future<void> connect() async {
    if (isEnabled) {
      final accs = await ethereum!.requestAccount();
      print(accs);
      if (accs.isNotEmpty) currentAddress = accs.first;
      currentChain = await ethereum!.getChainId();
      notifyListeners();
    }
  }

  start() {
    if (isEnabled) {
      ethereum!.onAccountsChanged((accounts) {
        reset();
      });
      ethereum!.onChainChanged((accounts) {
        reset();
      });
    }
  }

  reset() {
    currentAddress = "";
    currentChain = -1;
    notifyListeners();
  }
}

*/