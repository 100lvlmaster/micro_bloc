import 'package:example/bloc/counter/counter_bloc.dart';
import 'package:example/bloc/counter/counter_events.dart';
import 'package:example/bloc/counter/counter_state.dart';
import 'package:flutter/material.dart';
import 'package:micro_bloc/bloc_builder.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter micro bloc'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final CounterBloc _bloc;
  @override
  void initState() {
    super.initState();
    _bloc = CounterBloc();
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: BlocBuilder<CounterEvent, CounterState>(
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
      floatingActionButton: Row(
        children: [
          FloatingActionButton(
            onPressed: () => _bloc.add(const IncrementEvent()),
            child: const Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: () => _bloc.add(const DecrementEvent()),
            child: const Icon(Icons.remove),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
