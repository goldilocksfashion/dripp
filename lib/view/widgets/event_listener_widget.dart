import 'package:dripp/events/event_listener.dart';
import 'package:flutter/material.dart';

abstract class EventListenerWidget<T> extends StatefulWidget {
  final EventListener<T> eventListener;

  const EventListenerWidget({super.key, required this.eventListener});
}
