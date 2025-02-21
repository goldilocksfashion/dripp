import 'package:rxdart/rxdart.dart';

mixin EventListener<T> {
  late final BehaviorSubject<T> event$;
}
