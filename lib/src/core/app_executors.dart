import 'dart:async';

class AppExecutors {
   Timer? _timer;

  void execute(Function() method) {
    if (_timer == null) {
      method.call();
      _timer = Timer(
        const Duration(milliseconds: 5000),
        () {
          _timer = null;
        },
      );
    }
  }
}
