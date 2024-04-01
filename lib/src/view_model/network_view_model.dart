import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class NetworkViewModel {
  final ValueNotifier<bool> _mConnected = ValueNotifier(false);

  void registerNetworkStateObserver() {
    Connectivity().onConnectivityChanged.listen((event) {
      _mConnected.value = event.contains(ConnectivityResult.none);
    });
  }

  ValueNotifier<bool> getConnected() {
    return _mConnected;
  }
}
