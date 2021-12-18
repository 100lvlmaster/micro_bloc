import 'dart:async';

import 'package:flutter/material.dart';
import 'package:micro_bloc/bloc.dart';

typedef BlocWidgetListener<S> = void Function(BuildContext context, S state);

typedef BlocListenerCondition<S> = bool Function(S previous, S current);

class BlocListener<E, S> extends StatefulWidget {
  final Bloc<E, S> bloc;
  final BlocWidgetListener<S> listener;
  final BlocListenerCondition<S>? listenWhen;
  final Widget child;

  const BlocListener({
    Key? key,
    required this.bloc,
    required this.listener,
    required this.child,
    this.listenWhen,
  }) : super(key: key);

  @override
  _BlocListenerState<E, S> createState() => _BlocListenerState<E, S>();
}

class _BlocListenerState<E, S> extends State<BlocListener<E, S>> {
  late S? _previousState;
  late Bloc<E, S> _bloc;
  StreamSubscription<S>? _subscription;

  /// Initialize bloc and set the initial state as [_previousState]
  @override
  void initState() {
    super.initState();
    _bloc = widget.bloc;
    _previousState = _bloc.initial;
    _subscribe();
  }

  ///
  @override
  void didUpdateWidget(BlocListener<E, S> oldWidget) {
    super.didUpdateWidget(oldWidget);
    final Bloc<E, S> oldBloc = oldWidget.bloc;
    final Bloc<E, S> currentBloc = widget.bloc;
    if (oldBloc != currentBloc) {
      if (_subscription != null) {
        _unsubscribe();
        _bloc = currentBloc;
        _previousState = _bloc.initial;
      }
      _subscribe();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final Bloc<E, S> bloc = widget.bloc;
    if (_bloc != bloc) {
      if (_subscription != null) {
        _unsubscribe();
        _bloc = bloc;
        _previousState = _bloc.initial;
      }
      _subscribe();
    }
  }

  void _subscribe() {
    _subscription = _bloc.stream.listen((state) {
      if (mounted &&
          (widget.listenWhen?.call(_previousState ?? _bloc.initial, state) ??
              true)) {
        widget.listener(context, state);
        _previousState = state;
      }
    });
  }

  void _unsubscribe() {
    _subscription?.cancel();
    _subscription = null;
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
