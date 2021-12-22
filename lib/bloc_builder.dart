import 'package:flutter/widgets.dart';
import 'package:micro_bloc/bloc.dart';

import 'bloc_listener.dart';

typedef BlocWidgetBuilder<T> = Widget Function(BuildContext context, T state);
typedef BlocBuilderCondition<S> = bool Function(S previous, S current);

@immutable
class BlocBuilder<E, S> extends StatefulWidget {
  final BlocBuilderCondition<S>? buildWhen;
  final BlocWidgetBuilder<S> builder;
  final Bloc<E, S> bloc;
  const BlocBuilder({
    Key? key,
    this.buildWhen,
    required this.builder,
    required this.bloc,
  }) : super(key: key);

  @override
  _BlocBuilderState<E, S> createState() => _BlocBuilderState<E, S>();
}

class _BlocBuilderState<E, S> extends State<BlocBuilder<E, S>> {
  late Bloc<E, S> _bloc;
  late S _state;

  @override
  void initState() {
    super.initState();
    _bloc = widget.bloc;
    _state = _bloc.initial;
  }

  @override
  void didUpdateWidget(BlocBuilder<E, S> oldWidget) {
    super.didUpdateWidget(oldWidget);
    final Bloc<E, S> oldBloc = oldWidget.bloc;
    final Bloc<E, S> currentBloc = widget.bloc;
    if (oldBloc != currentBloc) {
      _bloc = currentBloc;
      _state = _bloc.initial;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final Bloc<E, S> bloc = widget.bloc;
    if (_bloc != bloc) {
      _bloc = bloc;
      _state = _bloc.initial;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<E, S>(
      bloc: widget.bloc,
      listenWhen: widget.buildWhen,
      listener: (context, state) => setState(() => _state = state),
      child: widget.builder(context, _state),
    );
  }
}
