import 'package:flutter/material.dart';

@immutable
abstract class CounterState {
  const CounterState();
}

class CounterStateInitial extends CounterState {
  final int value;
  const CounterStateInitial(this.value);
}

class ValueBelowZero extends CounterState {
  const ValueBelowZero();
}

class UpdateValue extends CounterState {
  final int value;
  const UpdateValue(this.value);
}
