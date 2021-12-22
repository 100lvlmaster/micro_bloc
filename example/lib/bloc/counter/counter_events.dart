import 'package:flutter/foundation.dart';

@immutable
abstract class CounterEvent {
  const CounterEvent();
}

class IncrementEvent extends CounterEvent {
  const IncrementEvent();
}

class DecrementEvent extends CounterEvent {
  const DecrementEvent();
}
