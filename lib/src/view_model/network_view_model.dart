import 'dart:async';

import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class NetworkViewModel {
  final InternetConnectionChecker _connectivity = InternetConnectionChecker();
  final ValueNotifier<bool> _mConnected = ValueNotifier(false);
  late final StreamSubscription<InternetConnectionStatus> _stream;


  void registerNetworkStateObserver() {
    _connectivity.hasConnection.then((value) {
      _mConnected.value = value;
    });
    _stream = _connectivity.onStatusChange.listen((event) {
      _mConnected.value = event == InternetConnectionStatus.connected;
    });
  }

  ValueNotifier<bool> getConnected() {
    return _mConnected;
  }

  void dispose() {
    _stream.cancel();
    _mConnected.dispose();
  }
}
