import 'package:rxdart/rxdart.dart';

/// Event broadcaster encapsulates eventstream of type T
/// and provides a broadcast method to broadcast events
mixin EventBroadcastingAgent<T> {
  late final BehaviorSubject<T> event$;

  void broadcast(T event) {
    event$.add(event);
  }

  void dispose() {
    event$.close();
  }
}
