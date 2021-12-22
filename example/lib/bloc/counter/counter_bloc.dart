import 'package:example/bloc/counter/counter_state.dart';
import 'package:micro_bloc/bloc.dart';

import 'counter_events.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(const CounterStateInitial(0));
  int counter = 0;

  /// Listen and emit states based on events
  @override
  void add(CounterEvent event) {
    if (event is IncrementEvent) {
      counter = counter + 1;
      if (counter < 0) {
        emit(const ValueBelowZero());
      }
      emit(UpdateValue(counter));
    }
    if (event is DecrementEvent) {
      counter = counter - 1;
      emit(UpdateValue(counter + 1));
    }
  }
}
