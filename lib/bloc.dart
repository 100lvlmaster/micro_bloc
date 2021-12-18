import 'dart:async';
import 'package:rxdart/subjects.dart';

/// Base BLoC class to create blocs
abstract class Bloc<E, S> {
  /// The stream assigned to this bloc
  late final BehaviorSubject<S> _controller;

  /// The initial state of this bloc taken from the implemented class
  ///
  final S initial;

  /// Add the initial state once
  Bloc(this.initial) {
    _controller = BehaviorSubject<S>()..add(initial);
  }

  /// Listenable stream
  Stream<S> get stream => _controller.stream;
  S get initialState => initial;

  /// Emit the state if the controller is not closed
  void emit(S state) {
    if (!_controller.isClosed) {
      _controller.add(state);
    }
  }

  /// On add callback implemented by the bloc child class
  ///
  void add(E event);

  /// Dispose method can call to override something
  void dispose() {
    _controller.close();
  }
}
