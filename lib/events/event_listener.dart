import 'package:rxdart/rxdart.dart';

mixin EventListener<T> {
  late final BehaviorSubject<T> event$;

  void listen(void Function(T event) onData) {
    event$.listen(onData);
  }

  void dispose() {
    event$.close();
  }
}
