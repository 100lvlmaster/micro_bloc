# MicroBLoC

![flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)


Micro bloc is a dead-simple flutter state management library made for quickly implementing the bloc pattern. It internally uses [rxdart](https://pub.dev/packages/rxdart) for streams. 

This package is great for small project. But for medium-large projects. I recommend using the official [bloc](https://pub.dev/packages/bloc) and [flutter_bloc](https://pub.dev/packages/flutter_bloc) libraries.

Things this library provides:
- Provides a BlocListener and BlocBuilder to listen and build on events.
- Bloc implementation in 200 lines of code.

You can find the example here: [example](https://github.com/100lvlmaster/micro_bloc)

Bloc:
```dart

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
```

BlocBuilder:
```dart
BlocBuilder<CounterEvent, CounterState>(
            bloc: _bloc,
            buildWhen: (previous, current) => current is! ValueBelowZero,
            builder: (context, CounterState state) {
              if (state is UpdateValue) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'You have pushed the button this many times:',
                    ),
                    Text(
                      '${state.value}',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ],
                );
              }
              return const SizedBox();
            },
          ),
        ),
```
BlocListener:
```dart
BlocListener<CounterEvent, CounterState>(
          bloc: _bloc,
          listener: (context, state) {
            if (state is ValueBelowZero) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Value is below zero')),
              );
            }
          },
)
```
Dispatching/Adding events:
```dart
FloatingActionButton(
            onPressed: () => _bloc.add(const IncrementEvent()),
            child: const Icon(Icons.add),
          ),
```

