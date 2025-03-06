import 'package:dripp/events/event.dart';

/// Event for account related actions.
class AccountEvent extends Event {
  AccountEvent(super.id, super.private_key);
}
