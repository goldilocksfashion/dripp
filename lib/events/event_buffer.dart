import 'dart:async';

/// Event Ring Buffer follows LMAX Disruptor pattern.
/// It is a fixed-size buffer that overwrites the oldest events when full.
/// It is used to store and retrieve events in a circular fashion.
/// Important thing is that it is used to buffer events from Rust FFI or any Dart Isolate
class EventBuffer<T> {
  final int capacity;
  int size = 0;
  final List<T?> _buffer;
  int read_index = 0;
  int write_index = 0;

  final StreamController<T> sc = StreamController<T>.broadcast();

  /// Pre-allocate a list of nulls to the capacity of the buffer.
  EventBuffer({required this.capacity})
      : _buffer = List<T?>.filled(capacity, null, growable: false);

  Stream<T> get events$ => sc.stream;

  // Get all current events as a list (for debugging or bulk operations)
  // FIXME: This is not efficient for large buffers, but it's fine for small buffers
  // TODO: DO NOT USE THIS IN PRODUCTION
  List<T> get events {
    final result = <T>[];
    for (int i = 0; i < size; i++) {
      final index = (read_index + i) % capacity;
      final event = _buffer[index];
      if (event != null) {
        result.add(event);
      }
    }
    return result;
  }

  void add(T event) {
    this.write_index = (write_index + 1) % capacity;
    _buffer[this.write_index] = event;
    size = size < capacity ? size + 1 : capacity;
    sc.add(event);
  }

  T? read() {
    if (size == 0) {
      return null; // Return null if buffer is empty
    }
    final event = _buffer[read_index];
    final _new_read_index = (read_index + 1) % capacity;
    if (_new_read_index < write_index) {
      this.read_index = _new_read_index;
    } // continue to affix read index < write index, read index should always be behind write.
    return event;
  }

  bool get isEmpty => size == 0;
  bool get isFull => size == capacity;
  int get length => size;

  void resetReadIndex() {
    this.read_index = (this.write_index - this.size + capacity) % capacity;
  }
}
